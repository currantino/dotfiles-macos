import sys
import re

def format_promela(code):
    # Remove extra whitespace
    code = re.sub(r'\s+', ' ', code)
    
    # Add newlines after semicolons and braces
    code = re.sub(r';(?!\n)', ';\n', code)
    code = re.sub(r'\{', '{\n', code)
    code = re.sub(r'\}', '\n}\n', code)
    
    # Indentation logic
    formatted_code = []
    indent_level = 0
    for line in code.splitlines():
        line = line.strip()
        if not line:
            continue
        
        # Decrease indentation for closing braces
        if line.startswith('}'):
            indent_level -= 1
        
        # Add indentation
        formatted_code.append('    ' * indent_level + line)
        
        # Increase indentation for opening braces
        if line.endswith('{'):
            indent_level += 1
    
    return '\n'.join(formatted_code)

if __name__ == "__main__":
    code = sys.stdin.read()
    formatted_code = format_promela(code)
    print(formatted_code)
