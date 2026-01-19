## Minimal HTTP GET & POST Server in x86_64 Assembly (Linux)

  This project is a minimal concurrent HTTP web server implemented entirely in x86_64 Linux assembly (Intel syntax) using raw Linux syscalls.
  It supports HTTP GET and POST requests, basic request parsing, and concurrent client handling via process forking.

  The primary goal of this project is deep systems-level understanding and security-oriented learning, not production deployment.

## Why This Project Matters

  Most web servers abstract away critical details using high-level frameworks.
  This project intentionally removes those abstractions to demonstrate:
    
    - Strong understanding of operating system internals

Ability to work close to hardware and kernel interfaces

Deep knowledge of network protocols (HTTP over TCP)

Awareness of security risks caused by unsafe parsing

Comfort with low-level debugging and memory reasoning

Building a working web server in assembly highlights foundational skills that directly transfer to:

Cybersecurity (offensive & defensive)

Exploit development

Reverse engineering

Systems programming

Performance-critical backend work

Key Features

TCP server built using Linux syscalls only

Concurrent client handling using fork()

HTTP request parsing at byte level

GET request support (file serving)

POST request support (writes request body to file)

Zero external libraries (no libc, no frameworks)

Supported HTTP Methods
Method	Behavior
GET	Reads requested file and returns contents
POST	Extracts HTTP body and writes it to a file
Others	Connection closed
Technical Stack

Language: x86_64 Assembly (Intel syntax)

OS: Linux (64-bit)

Assembler: NASM / GAS (Intel mode)

Concurrency Model: fork()

Networking: Raw TCP sockets

HTTP Version: Minimal HTTP/1.0 handling

High-Level Architecture

Create TCP socket

Bind to port

Listen for connections

Accept client

Fork child process

Read raw HTTP request

Detect request method (GET / POST)

Parse request path and body

Handle request

Send HTTP response

Close connection

All logic is implemented using direct system calls, without any runtime or standard library support.

Build & Run
Assemble and Link
nasm -f elf64 server.asm -o server.o
ld server.o -o server

Run
./server

Test GET
curl http://localhost:20480/example.txt

Test POST
curl -X POST http://localhost:20480/output.txt -d "Hello World"

Security Perspective (Intentional Learning Focus)

This project deliberately exposes common security risks found in real-world software:

Unsafe input parsing

Lack of bounds checking

No path traversal protection

No request size validation

No authentication or authorization

No HTTPS or encryption

Vulnerable to malformed requests

These weaknesses are intentional and make the project useful for:

Understanding how parsing bugs arise

Practicing exploit development

Studying attack surfaces in custom servers

Learning why secure frameworks exist

Learning Outcomes

Through this project, I strengthened my understanding of:

Linux syscall interface

TCP socket lifecycle

HTTP protocol internals

Process management

Buffer handling and memory safety

Security implications of low-level code

Why improper parsing leads to vulnerabilities

Use Cases

Cybersecurity learning and research

Systems programming practice

Reverse engineering reference

CTF preparation (web + pwn)

Demonstrating low-level expertise to recruiters

Notes on Development

This project was built with guided assistance and iterative refinement.
All code paths were reviewed, understood, tested, and modified manually.

The focus of this repository is learning, transparency, and technical depth, not claiming exclusive originality.

Future Enhancements (Optional)

Add 404 / 405 HTTP responses

Implement Content-Length validation

Prevent directory traversal

Replace fork() with select() or epoll

Add intentional vulnerabilities for exploit labs

Extend to additional HTTP methods

License

MIT License — free to use for learning, research, and experimentation.

Final Note (Recruiter Context)

This project demonstrates how I approach systems, security, and low-level engineering problems:
by understanding fundamentals, questioning abstractions, and building from the ground up.
