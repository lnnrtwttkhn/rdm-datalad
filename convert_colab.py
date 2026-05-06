import re

def replace_bash_chunk(match):
    """Convert bash chunk to python with jupyter magics."""
    # Extract the command content
    command_content = match.group(1)

    # Check for heredoc pattern: cat << EOT > file or cat << EOT >> file
    heredoc_match = re.match(
        r'\s*cat\s+<<\s*EOT\s*(>>?)\s*(\S+)\n(.*?)\nEOT\s*$',
        command_content,
        re.DOTALL
    )
    if heredoc_match:
        mode = heredoc_match.group(1)
        filename = heredoc_match.group(2)
        content = heredoc_match.group(3)
        flag = '-a ' if mode == '>>' else ''
        return f"```{{python}}\n%%writefile {flag}{filename}\n{content}\n```"

    # Add ! magic to each line that isn't empty
    lines = command_content.split('\n')
    python_lines = []
    continuation = False
    for line in lines:
        if continuation:
            python_lines.append(line)
        elif re.match(r'\s*cd\b', line):  # cd must use %cd to persist in kernel
            python_lines.append(f"%{line}")
        elif line.strip():  # other non-empty lines use ! to run in shell
            python_lines.append(f"!{line}")
        else:
            python_lines.append(line)
        continuation = line.rstrip().endswith('\\')

    return f"```{{python}}\n{chr(10).join(python_lines)}\n```"

def process_exercise_file(input_file, output_file):
    """Process exercise file to convert bash chunks to python with jupyter magics."""
    with open(input_file, "r") as f:
        content = f.read()

    # Update the YAML header to specify python kernel
    content = re.sub(r'jupyter: bash', 'jupyter: python3', content)

    # Remove lines that contain #|
    lines = content.split('\n')
    filtered_lines = [line for line in lines if '#|' not in line]
    content = '\n'.join(filtered_lines)

    # Find and replace all bash chunks
    content = re.sub(r'```\{bash\}\n(.*?)\n```', replace_bash_chunk, content, flags=re.DOTALL)

    # Write the modified content to a new file
    with open(output_file, "w") as f:
        f.write(content)

    print(f"Generated {output_file} with bash chunks converted to python with jupyter magics")

def convert_all_exercises():
    """Convert all exercise files for Colab compatibility."""
    # Process both exercise files
    process_exercise_file("tutorial.qmd", "tutorial_colab.qmd")

if __name__ == "__main__":
    convert_all_exercises()