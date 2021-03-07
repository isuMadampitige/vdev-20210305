1. git init

2. git add README.md

3. git commit -m "first commit"

4. git remote add origin https://github.com/isuMadampitige/vdev-20210305.git

5. git push -u origin master

6. Flutter Setup Steps

  System Requirements
      •	OS: windows 7 or later
      •	Disk space: 1.32GB

  Get the flutter SDK
      1.	Download flutter sdk from here:
          •	https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_2.0.1-stable.zip
      2.	Extract the zip file and place the contained flutter in the desired installation location for the Flutter SDK (for example, C:\src\flutter).

  Get the Android SDK
      1.	Download and install Android Studio from here: https://developer.android.com/studio.
      2.	Start Android Studio, and go through the ‘Android Studio Setup Wizard’. This installs the latest Android SDK, Android SDK Command-line Tools, and Android SDK Build-             Tools,   which are required by Flutter when developing for Android.


  Update your Path
      1. Go to the Edit environment variables for your account.
      2. First, add your android sdk path inside user variables (eg:- C:\Users\Isuru\AppData\Local\Android\Sdk  value :%ANDROID_HOME%)
      3. Under user variables there is entry call Path,
          •	Add your flutter\bin directory path (C:\src\flutter\bin)
          •	(%ANDROID_HOME%\tools)
          •	(%ANDROID_HOME%\platform-tools)
          •	(%ANDROID_HOME%\emulator)
          •	(%ANDROID_HOME%\build-tools)
          •	add all variable paths.

  ***	From a console window that has the Flutter directory in the path (see above), run the following command to see if there are any platform dependencies you need to complete       the setup:
          • flutter doctor


    Get the VS code IDE
      1. Download the latest vs code IDE here: https://code.visualstudio.com/
          •	Install flutter and Dart plugins
          •	Start VS Code.
          •	Invoke View > Command Palette….
          •	Type “install”, and select Extensions: Install Extensions.
          •	Type “flutter” in the extensions search field, select Flutter in the list, and click Install. This also installs the required Dart plugin.


    Setup android emulator
          1. Launch Android Studio, click the AVD Manager icon, and select Create Virtual Device…

    ***	After that again run flutter doctor command to check the installation dependencies.
    
  7.   announcing Flutter 2: a major upgrade to Flutter that enables developers to create beautiful, fast, and portable apps for any platform.

        Flutter can even be embedded in cars, TVs, and smart home appliances, providing the most pervasive and portable experience for an ambient computing world.

        Support Flutter from a mobile framework to a portable framework.


