import os
import subprocess
from datetime import datetime

def upload_to_github():
    # Get the current directory
    current_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Check if we're in the correct repository
    if not os.path.exists(os.path.join(current_dir, '.git')):
        print("Error: Not in a git repository. Please run this script from within the coops-malanje repository.")
        return
    
    # Check if remote is set up
    try:
        subprocess.run(['git', 'remote', '-v'], cwd=current_dir, check=True)
    except subprocess.CalledProcessError:
        print("Error: Git remote not configured. Please set up the remote repository first.")
        print("You can do this with: git remote add origin https://github.com/KAYA-Global/coops-malanje.git")
        return
    
    # Get current branch
    branch = subprocess.check_output(['git', 'rev-parse', '--abbrev-ref', 'HEAD'], 
                                   cwd=current_dir).decode().strip()
    
    # Add all files
    subprocess.run(['git', 'add', '.'], cwd=current_dir)
    
    # Check if there are changes to commit
    status = subprocess.check_output(['git', 'status', '--porcelain'], 
                                   cwd=current_dir).decode().strip()
    if not status:
        print("No changes to commit.")
        return
    
    # Commit with timestamp
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    commit_message = f'Update analysis files - {timestamp}'
    subprocess.run(['git', 'commit', '-m', commit_message], cwd=current_dir)
    
    # Push to GitHub
    try:
        subprocess.run(['git', 'push', 'origin', branch], cwd=current_dir, check=True)
        print(f"Successfully uploaded files to GitHub on branch {branch}")
    except subprocess.CalledProcessError as e:
        print(f"Error uploading to GitHub: {e}")
        print("Please make sure you have the necessary permissions and your local branch is up to date.")
        print("You may need to pull changes first with: git pull origin main")

if __name__ == "__main__":
    upload_to_github() 