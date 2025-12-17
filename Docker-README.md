# Diagram Converter CLI Tool (Docker Version)

A powerful CLI tool for converting Mermaid diagrams to Draw.io XML format with professional layouts, containerized with Docker for easy deployment and usage.

## Features

- **Multiple Diagram Types**: Supports flowcharts, sequence diagrams, and mindmaps
- **Professional Layouts**: Uses Dagre library for automatic node positioning and edge routing
- **Docker Containerized**: No installation required - run anywhere Docker is available
- **Command Line Interface**: Simple commands for conversion and validation
- **Batch Processing**: Convert multiple diagrams at once

## Quick Start

### Prerequisites
- Docker installed on your system

### Basic Usage

1. **Convert a Mermaid diagram to Draw.io format:**
   ```bash
   docker run --rm -v "$(pwd)":/app diagram-converter to-drawio your-diagram.mmd
   ```

2. **Validate a Mermaid diagram:**
   ```bash
   docker run --rm -v "$(pwd)":/app diagram-converter validate your-diagram.mmd
   ```

3. **Convert to Markdown documentation:**
   ```bash
   docker run --rm -v "$(pwd)":/app diagram-converter to-markdown your-diagram.mmd
   ```

## Commands

| Command | Description | Example |
|---------|-------------|---------|
| `to-drawio <file>` | Convert Mermaid to Draw.io XML | `docker run --rm -v "$(pwd)":/app diagram-converter to-drawio flowchart.mmd` |
| `to-markdown <file>` | Convert Mermaid to Markdown | `docker run --rm -v "$(pwd)":/app diagram-converter to-markdown diagram.mmd` |
| `validate <file>` | Validate Mermaid syntax | `docker run --rm -v "$(pwd)":/app diagram-converter validate diagram.mmd` |
| `convert <input> <output>` | Convert with custom output path | `docker run --rm -v "$(pwd)":/app diagram-converter convert input.mmd output.drawio` |

## Docker Volume Mounting

The `-v "$(pwd)":/app` flag mounts your current directory to the container's `/app` directory, allowing the tool to:
- Read input Mermaid files from your local directory
- Write output files back to your local directory

**Important:** Always use quotes around `$(pwd)` if your path contains spaces:
```bash
docker run --rm -v "$(pwd)":/app diagram-converter to-drawio "my diagram.mmd"
```

## Examples

### Flowchart Conversion
```bash
# Create a simple flowchart
echo 'flowchart TD
    A[Start] --> B{Decision}
    B -->|Yes| C[Action 1]
    B -->|No| D[Action 2]
    C --> E[End]
    D --> E' > example.mmd

# Convert to Draw.io
docker run --rm -v "$(pwd)":/app diagram-converter to-drawio example.mmd

# Result: example.drawio file created
```

### Sequence Diagram
```bash
# Create a sequence diagram
echo 'sequenceDiagram
    participant A as Alice
    participant B as Bob
    A->>B: Hello
    B-->>A: Hi there!' > sequence.mmd

# Convert to Draw.io
docker run --rm -v "$(pwd)":/app diagram-converter to-drawio sequence.mmd
```

### Mindmap
```bash
# Create a mindmap
echo 'mindmap
    root((Project))
        Development
            Frontend
            Backend
        Testing
            Unit Tests
            Integration' > mindmap.mmd

# Convert to Draw.io
docker run --rm -v "$(pwd)":/app diagram-converter to-drawio mindmap.mmd
```

## Advanced Usage

### Custom Output Directory
```bash
# Mount specific directories
docker run --rm \
  -v "$(pwd)/input":/app/input \
  -v "$(pwd)/output":/app/output \
  diagram-converter to-drawio input/diagram.mmd

# Output will be in your local output/ directory
```

### Batch Conversion
```bash
# Convert multiple files
for file in *.mmd; do
  docker run --rm -v "$(pwd)":/app diagram-converter to-drawio "$file"
done
```

## Troubleshooting

### Common Issues

1. **"File not found" error:**
   - Ensure the input file exists in your current directory
   - Check file permissions
   - Use absolute paths if needed

2. **"Permission denied" error:**
   - The container runs as a non-root user for security
   - Ensure your local files have appropriate read/write permissions

3. **Path with spaces:**
   - Always quote `$(pwd)`: `-v "$(pwd)":/app`

4. **Docker not found:**
   - Ensure Docker Desktop is installed and running
   - Try `docker --version` to verify

### Getting Help
```bash
# Show available commands
docker run --rm diagram-converter --help

# Show command-specific help
docker run --rm diagram-converter to-drawio --help
```

## Architecture

The tool consists of several components:
- **CLI Interface**: Commander.js for command parsing
- **Parser**: Custom Mermaid syntax parser
- **Layout Engine**: Dagre for professional graph layouts
- **XML Generator**: Converts parsed diagrams to Draw.io XML format
- **Docker Container**: Node.js 18 Alpine-based container

## Security

- Container runs as non-root user (`diagramuser`)
- Minimal Alpine Linux base image
- No privileged access required
- Read-only access to container filesystem

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with Docker
5. Submit a pull request

## License

MIT License - see LICENSE file for details

## Support

For issues or questions:
- Check the troubleshooting section
- Open an issue on GitHub
- Review the main README for development setup
