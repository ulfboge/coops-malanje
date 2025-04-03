from http.server import HTTPServer, SimpleHTTPRequestHandler
import os
import json
import socket
import sys
from functools import partial

class CustomHandler(SimpleHTTPRequestHandler):
    def __init__(self, *args, directory=None, **kwargs):
        if directory is None:
            directory = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        self.directory = directory
        super().__init__(*args, directory=directory, **kwargs)

    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Cache-Control', 'no-cache')
        if self.path.endswith('.geojson'):
            self.send_header('Content-Type', 'application/geo+json')
        super().end_headers()

    def do_GET(self):
        print(f"Received request for: {self.path}")
        try:
            if self.path.endswith('.geojson'):
                file_path = os.path.join(self.directory, self.path.lstrip('/'))
                print(f"Attempting to read file: {file_path}")
                
                if not os.path.exists(file_path):
                    print(f"File not found: {file_path}")
                    self.send_error(404, f"File not found: {self.path}")
                    return
                
                print(f"File exists: {os.path.exists(file_path)}")
                try:
                    with open(file_path, 'r') as f:
                        content = f.read()
                        # Validate JSON
                        json.loads(content)
                        self.send_response(200)
                        self.send_header('Content-Type', 'application/geo+json')
                        self.send_header('Content-Length', str(len(content)))
                        self.end_headers()
                        self.wfile.write(content.encode())
                        print(f"Successfully served GeoJSON file: {self.path}")
                        print(f"Content length: {len(content)} bytes")
                        return
                except json.JSONDecodeError:
                    print(f"Invalid JSON in file: {file_path}")
                    self.send_error(500, f"Invalid JSON in file: {self.path}")
                    return
                except Exception as e:
                    print(f"Error reading file: {e}")
                    self.send_error(500, f"Error reading file: {str(e)}")
                    return
            
            return super().do_GET()
        except Exception as e:
            print(f"Unexpected error: {e}")
            self.send_error(500, f"Internal server error: {str(e)}")

def is_port_in_use(port):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        return s.connect_ex(('localhost', port)) == 0

def find_available_port(start_port=8000, max_attempts=10):
    port = start_port
    while port < start_port + max_attempts:
        if not is_port_in_use(port):
            return port
        port += 1
    raise RuntimeError(f"No available ports found between {start_port} and {start_port + max_attempts - 1}")

def run(server_class=HTTPServer, handler_class=CustomHandler, start_port=8000):
    try:
        port = find_available_port(start_port)
        server_address = ('', port)
        directory = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        handler = partial(handler_class, directory=directory)
        httpd = server_class(server_address, handler)
        
        print(f"Starting server on port {port}...")
        print(f"Serving files from: {directory}")
        print(f"Access the map at: http://localhost:{port}/web/index.html")
        print("Press Ctrl+C to stop the server")
        
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nShutting down server...")
        httpd.server_close()
        sys.exit(0)
    except Exception as e:
        print(f"Error starting server: {e}")
        sys.exit(1)

if __name__ == '__main__':
    run() 