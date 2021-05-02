extends Node
class_name dialogue_piece

# Como a opção vai ser mostrada nas opções:
var option_name = "undefined"

# Próximas linhas de diálogo (caso ela leve a mais diálogo)
var lines = []

# Mais opções depois dela!
var next_opts = null

# Funções que vão ser chamadas depois que ela for escolhida!
var calls = ["_dialogue"]
