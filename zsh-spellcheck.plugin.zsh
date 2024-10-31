# Verificación de dependencia de aspell
command -v aspell >/dev/null 2>&1 || {
    echo "Error: aspell no está instalado. Por favor, instálalo con 'sudo apt install aspell' o el gestor de paquetes de tu sistema."
    return 1
}

# Variables globales para gestionar la navegación de sugerencias
suggestions=()        # Lista de sugerencias
current_suggestion=0  # Índice actual de sugerencia

# Función para verificar ortografía de una palabra
spellcheck_word() {
    local word="$1"
    local result
    result=$(echo "$word" | aspell -a | grep -E '^&|^#')
    
    if [[ -n $result ]]; then
        return 1 # Palabra incorrecta
    else
        return 0 # Palabra correcta
    fi
}

# Función que verifica la ortografía de cada palabra, excluyendo el comando
spellcheck_buffer() {
    local words
    words=("${(s: :)BUFFER}") # Divide el comando en palabras
    
    # Omite la primera palabra, que es el comando
    for word in "${words[@]:1}"; do
        # Utiliza aspell para verificar la palabra y capturar sugerencias
        suggestions=($(echo "$word" | aspell -a -d es | grep '^&' | awk -F': ' '{print $2}' | tr ',' ' '))
        
        if [[ ${#suggestions[@]} -gt 0 ]]; then
            current_suggestion=0 # Reinicia el índice de sugerencias
            zle -M "Error de ortografía: \"$word\". Sugerencias: ${suggestions[*]}"
            return 0
        fi
    done
    zle -M "" # Limpia el mensaje si no hay errores
}

# Función para cambiar la palabra por la sugerencia seleccionada al presionar Tab
cycle_suggestions() {
    if [[ ${#suggestions[@]} -gt 0 ]]; then
        # Reemplaza la palabra actual con la sugerencia en la posición actual
        BUFFER="${BUFFER/%${words[-1]}/$suggestions[$current_suggestion]}"
        
        # Avanza en las sugerencias cíclicamente
        ((current_suggestion = (current_suggestion + 1) % ${#suggestions[@]}))
        zle redisplay # Actualiza el display de Zsh
    fi
}

# Función para insertar un espacio sin activar el corrector
insert_space_no_spellcheck() {
    zle self-insert # Inserta el espacio sin llamar a spellcheck_buffer
}

# Función para enviar el comando sin activar el corrector
send_command_no_spellcheck() {
    zle accept-line # Acepta la línea sin llamar a spellcheck_buffer
}

# Widgets que activan el corrector ortográfico y las sugerencias
zle -N spellcheck_buffer
zle -N cycle_suggestions
zle -N insert_space_no_spellcheck
zle -N send_command_no_spellcheck

# Enlaza las teclas para el corrector y la navegación de sugerencias
bindkey ' ' spellcheck_buffer            # Activa el corrector con espacio
bindkey '^M' spellcheck_buffer           # Activa el corrector con Enter
bindkey '^I' cycle_suggestions           # Activa la navegación de sugerencias con Tab
bindkey '^ ' insert_space_no_spellcheck  # Inserta espacio sin corrector con Ctrl + Espacio
bindkey '^M' spellcheck_buffer           # Activa el corrector con Enter
bindkey '^J' send_command_no_spellcheck  # Enviar comando sin corrector con Ctrl + Enter
