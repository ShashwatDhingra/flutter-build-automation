Flutter Build & Share Automation 🚀

Automate the entire Flutter build → upload → share workflow with a single command.

This script builds your Flutter app (Android or iOS), uploads the generated artifact, and instantly returns a shareable installation link for testers.

No more manually building APK/IPA, uploading it, and then sharing links.

✨ Features

• Build Android APK automatically
• Build iOS IPA automatically
• Upload build to Loadly
• Generate instant install link for testers
• Works with one command
• Lightweight shell script (no CI setup required)

⚙️ How It Works

The script performs the following steps:

Detects the platform flag (--a or --i)
Builds the Flutter project
Locates the generated build artifact
Uploads it to the distribution service
Extracts and prints the install link

Example output:

📦 Building Android APK...
🚀 Uploading to Loadly...
📩 Response received...
✅ Upload successful!
🔗 Install Link: https://loadly.io/abc123
📂 Project Structure
flutter-build-share/
│
├── build.sh
├── README.md
└── ios/
    └── ExportOptions.plist
🛠 Requirements

Make sure the following are installed:

• Flutter SDK
• Xcode (for iOS builds)
• macOS (required for IPA build)
• curl

🔑 Setup

Set your API key as an environment variable.

export LOADLY_API_KEY=your_api_key_here

This avoids exposing credentials inside the script.

🚀 Usage

Make the script executable:

chmod +x build.sh
Build Android
./build.sh --a
Build iOS
./build.sh --i

After completion, the script prints a shareable install link.

📱 Example Workflow

Instead of doing this manually:

Run Flutter build
Find the APK/IPA
Upload to a distribution platform
Copy installation link
Share with testers

You can now simply run:

./build.sh --a

and get the install link instantly.

💡 Why I Built This

While working on Flutter apps, I noticed the build and distribution process during testing cycles was repetitive.

This small automation script reduces the process to a single command, saving time during development and QA.

🤝 Contributions

Contributions, suggestions, and improvements are welcome.

If you find this helpful, feel free to star the repository ⭐.

🧑‍💻 Author

Shashwat Dhingra

Flutter Developer | Mobile App Developer
