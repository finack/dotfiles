# Markdown Preview Test

This is a test markdown file to verify the preview functionality works correctly.

## Regular Markdown Features

- **Bold text**
- *Italic text*
- `inline code`
- [Link example](https://example.com)

### Code Block
```javascript
function hello() {
  console.log("Hello, World!");
}
```

## Mermaid Diagram Test

```mermaid
graph TD
    A[Start] --> B{Is it working?}
    B -->|Yes| C[Great!]
    B -->|No| D[Debug]
    D --> B
    C --> E[End]
```

## Flowchart Example

```mermaid
flowchart LR
    A[Hard] --> B(Round)
    B --> C{Decision}
    C -->|One| D[Result 1]
    C -->|Two| E[Result 2]
```

## Sequence Diagram

```mermaid
sequenceDiagram
    participant A as Alice
    participant B as Bob
    A->>B: Hello Bob, how are you?
    B-->>A: Great, thanks for asking!
```

## Math (KaTeX)

Inline math: $E = mc^2$

Block math:
$$
\int_0^\infty e^{-x^2} dx = \frac{\sqrt{\pi}}{2}
$$