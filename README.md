## Minimal HTTP GET & POST Server in x86_64 Assembly (Linux)

  This project is a minimal concurrent HTTP web server implemented entirely in x86_64 Linux assembly (Intel syntax) using raw Linux syscalls.
  It supports HTTP GET and POST requests, basic request parsing, and concurrent client handling via process forking.

  The primary goal of this project is deep systems-level understanding and security-oriented learning, not production deployment.

---

## Why This Project Matters

  Most web servers abstract away critical details using high-level frameworks.
  This project intentionally removes those abstractions to demonstrate:
    
    - Strong understanding of operating system internals
    - Ability to work close to hardware and kernel interfaces
    - Deep knowledge of network protocols (HTTP over TCP)
    - Awareness of security risks caused by unsafe parsing
    - Comfort with low-level debugging and memory reasoning

---

## Key Features

    - TCP server built using Linux syscalls only
    - Concurrent client handling using fork()
    - HTTP request parsing at byte level
    - GET request support (file serving)
    - POST request support (writes request body to file)
    - Zero external libraries (no libc, no frameworks)

---

## Supported HTTP Methods

| Method | Behavior |
|------|---------|
| GET | Reads requested file and returns contents |
| POST | Extracts HTTP body and writes it to a file |
| Others | Connection closed |

---

## Technical Stack

- **Language:** x86_64 Assembly (Intel syntax)
- **OS:** Linux (64-bit)
- **Assembler:** NASM / GAS (Intel mode)
- **Concurrency Model:** `fork()`
- **Networking:** Raw TCP sockets
- **HTTP Version:** Minimal HTTP/1.0 handling

---

## High-Level Architecture

1. Create TCP socket  
2. Bind to port  
3. Listen for connections  
4. Accept client  
5. Fork child process  
6. Read raw HTTP request  
7. Detect request method (GET / POST)  
8. Parse request path and body  
9. Handle request  
10. Send HTTP response  
11. Close connection  

All logic is implemented using **direct system calls**, without any runtime or standard library support.

---

## Build & Run

### Assemble and Link
    ```bash
      nasm -f elf64 server.asm -o server.o
      ld server.o -o server

---

### Run
    ```bash
      ./server

---

### Test GET
    ```bash
      curl http://localhost:20480/example.txt

---

### Test POST
    ```bash
      curl -X POST http://localhost:20480/output.txt -d "Hello World"

---

## Security Perspective 

### This project deliberately exposes common security risks found in real-world software:
    - Unsafe input parsing
    - Lack of bounds checking
    - No path traversal protection
    - No request size validation
    - No authentication or authorization
    - No HTTPS or encryption
    - Vulnerable to malformed requests

### These weaknesses are intentional and make the project useful for:
    - Understanding how parsing bugs arise
    - Practicing exploit development
    - Studying attack surfaces in custom servers
    - Learning why secure frameworks exist

---

## Through this project, I strengthened my understanding of:
  
  1. Linux syscall interface
  2. TCP socket lifecycle
  3. HTTP protocol internals
  4. Process management
  5. Buffer handling and memory safety
  6. Security implications of low-level code
  7. Why improper parsing leads to vulnerabilities

---

## Notes on Development

  This project was built with guided assistance and iterative refinement.
  All code paths were reviewed, understood, tested, and modified manually.

  The focus of this repository is **learning, transparency, and technical depth**, not claiming exclusive originality.

---

## License

MIT License — free to use for learning, research, and experimentation.

---

## This project demonstrates how I approach systems, security, and low-level engineering problems: by understanding fundamentals, questioning abstractions, and building from the ground up.
