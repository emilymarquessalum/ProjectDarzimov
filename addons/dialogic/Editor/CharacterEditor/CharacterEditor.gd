@tool
extends ScrollContainer

var editor_reference
@onready var master_tree = get_node('../MasterTreeContainer/MasterTree')
var opened_character_data
var portrait_entry = load("res://addons/dialogic/Editor/CharacterEditor/PortraitEntry.tscn")
@onready var nodes = {
	'editor': $HBoxContainer/Container,
	'name': $HBoxContainer/Container/Name/LineEdit,
	'description': $HBoxContainer/Container/Description/TextEdit,
	'file': $HBoxContainer/Container/FileName/LineEdit,
	'color': $HBoxContainer/Container/Color/ColorPickerButton,
	'mirror_portraits_checkbox' : $HBoxContainer/VBoxContainer/HBoxContainer/MirrorOption/MirrorPortraitsCheckBox,
	'display_name_checkbox': $HBoxContainer/Container/Name/CheckBox,
	'display_name': $HBoxContainer/Container/DisplayName/LineEdit,
	'nickname_checkbox': $HBoxContainer/Container/Name/CheckBox2,
	'nickname': $HBoxContainer/Container/DisplayNickname/LineEdit,
	'new_portrait_button': $HBoxContainer/Container/ScrollContainer/VBoxContainer/HBoxContainer/Button,
	'import_from_folder_button': $HBoxContainer/Container/ScrollContainer/VBoxContainer/HBoxContainer/ImportFromFolder,
	'portrait_preview': $HBoxContainer/VBoxContainer/Control/TextureRect,
	'image_label': $"HBoxContainer/VBoxContainer/Control/Label",
	'scale': $HBoxContainer/VBoxContainer/HBoxContainer/Scale,
	'offset_x': $HBoxContainer/VBoxContainer/HBoxContainer/OffsetX,
	'offset_y': $HBoxContainer/VBoxContainer/HBoxContainer/OffsetY,
}


func _ready():
	nodes['new_portrait_button'].connect('pressed', Callable(self, '_on_New_Portrait_Button_pressed'))
	nodes['import_from_folder_button'].connect('pressed', Callable(self, '_on_Import_Portrait_Folder_Button_pressed'))
	nodes['display_name_checkbox'].connect('toggled', Callable(self, '_on_display_name_toggled'))
	nodes['nickname_checkbox'].connect('toggled', Callable(self, '_on_nickname_toggled'))
	nodes['name'].connect('text_changed', Callable(self, '_on_name_changed'))
	nodes['name'].connect('focus_exited', Callable(self, '_update_name_on_tree'))
	nodes['color'].connect('color_changed', Callable(self, '_on_color_changed'))
	var style = get('theme_override_styles/bg')
	style.set('bg_color', get_color("base_color", "Editor"))
	nodes['new_portrait_button'].icon = get_icon("Add", "EditorIcons")
	nodes['import_from_folder_button'].icon = get_icon("Folder", "EditorIcons")


func _on_display_name_toggled(button_pressed):
	$HBoxContainer/Container/DisplayName.visible = button_pressed


func _on_nickname_toggled(button_pressed):
	$HBoxContainer/Container/DisplayNickname.visible = button_pressed


func is_selected(file: String):
	return nodes['file'].text == file


func _on_name_changed(value):
	save_character()


func _update_name_on_tree():
	var item = master_tree.get_selected()
	item.set_text(0, nodes['name'].text)
	master_tree.build_characters(nodes['file'].text)
	

func _input(event):
	if event is InputEventKey and event.pressed:
		if nodes['name'].has_focus():
			if event.keycode == KEY_ENTER:
				nodes['name'].release_focus()


func _on_color_changed(color):
	var item = master_tree.get_selected()
	item.set_icon_modulate(0, color)


func clear_character_editor():
	nodes['file'].text = ''
	nodes['name'].text = ''
	nodes['description'].text = ''
	nodes['color'].color = Color('#ffffff')
	nodes['mirror_portraits_checkbox'].button_pressed = false
	nodes['display_name_checkbox'].button_pressed = false
	nodes['nickname_checkbox'].button_pressed = false
	nodes['display_name'].text = ''
	nodes['nickname'].text = ''
	nodes['portraits'] = []
	nodes['scale'].value = 100
	nodes['offset_x'].value = 0
	nodes['offset_y'].value = 0

	# Clearing portraits
	for p in $HBoxContainer/Container/ScrollContainer/VBoxContainer/PortraitList.get_children():
		p.queue_free()
	nodes['portrait_preview'].texture = null


# Character Creation
func create_character():
	var character_file = 'character-' + str(Time.get_unix_time_from_system()) + '.json'
	var character = {
		'color': '#ffffff',
		'id': character_file,
		'portraits': [],
		'mirror_portraits' :false
	}
	DialogicResources.set_character(character)
	character['metadata'] = {'file': character_file}
	return character


# Saving and Loading
func generate_character_data_to_save():
	var portraits = []
	for p in $HBoxContainer/Container/ScrollContainer/VBoxContainer/PortraitList.get_children():
		var entry = {}
		entry['name'] = p.get_node("NameEdit").text
		entry['path'] = p.get_node("PathEdit").text
		portraits.append(entry)
	var info_to_save = {
		'id': nodes['file'].text,
		'description': nodes['description'].text,
		'color': '#' + nodes['color'].color.to_html(),
		'mirror_portraits': nodes["mirror_portraits_checkbox"].pressed,
		'portraits': portraits,
		'display_name_bool': nodes['display_name_checkbox'].pressed,
		'display_name': nodes['display_name'].text,
		'nickname_bool': nodes['nickname_checkbox'].pressed,
		'nickname': nodes['nickname'].text,
		'scale': nodes['scale'].value,
		'offset_x': nodes['offset_x'].value,
		'offset_y': nodes['offset_y'].value,
	}
	# Adding name later for cases when no name is provided
	if nodes['name'].text != '':
		info_to_save['name'] = nodes['name'].text
	
	return info_to_save


func save_character():
	var info_to_save = generate_character_data_to_save()
	if info_to_save['id']:
		DialogicResources.set_character(info_to_save)
		opened_character_data = info_to_save


func load_character(filename: String):
	clear_character_editor()
	var data = DialogicResources.get_character_json(filename)
	opened_character_data = data
	nodes['file'].text = data['id']
	nodes['name'].text = data.get('name', '')
	nodes['description'].text = data.get('description', '')
	nodes['color'].color = Color(data.get('color','#ffffffff'))
	nodes['display_name_checkbox'].button_pressed = data.get('display_name_bool', false)
	nodes['display_name'].text = data.get('display_name', '')
	nodes['scale'].value = float(data.get('scale', 100))
	nodes['nickname_checkbox'].button_pressed = data.get('nickname_bool', false)
	nodes['nickname'].text = data.get('nickname', '')
	nodes['offset_x'].value = data.get('offset_x', 0)
	nodes['offset_y'].value = data.get('offset_y', 0)
	nodes['mirror_portraits_checkbox'].button_pressed = data.get('mirror_portraits', false)
	nodes['portrait_preview'].flip_h = data.get('mirror_portraits', false)

	# Portraits
	var default_portrait = create_portrait_entry()
	default_portrait.get_node('NameEdit').text = 'Default'
	default_portrait.get_node('NameEdit').editable = false
	if data.has('portraits'):
		for p in data['portraits']:
			if p['name'] == 'Default':
				default_portrait.get_node('PathEdit').text = p['path']
				default_portrait.update_preview(p['path'])
			else:
				create_portrait_entry(p['name'], p['path'])


# Portraits
func _on_New_Portrait_Button_pressed():
	create_portrait_entry('', '', true)


func create_portrait_entry(p_name = '', path = '', grab_focus = false):
	var p = portrait_entry.instantiate()
	p.editor_reference = editor_reference
	p.image_node = nodes['portrait_preview']
	p.image_label = nodes['image_label']
	var p_list = $HBoxContainer/Container/ScrollContainer/VBoxContainer/PortraitList
	p_list.add_child(p)
	if p_name != '':
		p.get_node("NameEdit").text = p_name
	if path != '':
		p.get_node("PathEdit").text = path
	if grab_focus:
		p.get_node("NameEdit").grab_focus()
		p._on_ButtonSelect_pressed()
	return p


func _on_Import_Portrait_Folder_Button_pressed():
	editor_reference.godot_dialog("*", EditorFileDialog.FILE_MODE_OPEN_DIR)
	editor_reference.godot_dialog_connect(self, "_on_dir_selected", "dir_selected")


func _on_dir_selected(path, target):
	var dir = DirAccess.new()
	if dir.open(path) == OK:
		dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var file_lower = file_name.to_lower()
				if '.svg' in file_lower or '.png' in file_lower:
					if not '.import' in file_lower:
						var final_name = path+ "/" + file_name
						create_portrait_entry(DialogicResources.get_filename_from_path(file_name), final_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func _on_MirrorPortraitsCheckBox_toggled(button_pressed):
	nodes['portrait_preview'].flip_h = button_pressed
