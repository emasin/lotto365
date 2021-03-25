# lotto365

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

회차별 조회
https://smok95.github.io/lotto/results/{회차번호}.json
최근회차 조회
https://smok95.github.io/lotto/results/latest.json
전체회차 조회
https://smok95.github.io/lotto/results/all.json


ios % flutter clean \                                                                       
&& rm ios/Podfile.lock pubspec.lock \
&& rm -rf ios/Pods ios/Runner.xcworkspace \
&& flutter build iOS


flutter pub cache repair   


// Step 1: Retrieve image from picker
final File image = await ImagePicker.pickImage(source: imageSource);

// Step 2: Check for valid file
if (image == null) return;

// Step 3: Get directory where we can duplicate selected file.
final String path = await getApplicationDocumentsDirectory().path;

// Step 4: Copy the file to a application document directory.
final var fileName = basename(file.path);
final File localImage = await image.copy('$path/$fileName');


// Step 1: Save image/file path as string either db or shared pref
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString('test_image', localImage.path)

// Step 2: Loading image by using the path that we saved earlier. We can create a file using path
//         and can use FileImage provider for loading image from file.
CircleAvatar(
backgroundImage: FileImage(File(prefs.getString('test_image')),
radius: 50,
backgroundColor: Colors.white)

