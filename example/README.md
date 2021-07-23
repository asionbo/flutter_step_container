# flutter_step_container

Stepper for Form or Introduce and so on

# Installing

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_step_container: ^0.0.1
```

### 2. Install it

You can install packages from the command line:

with `pub`:

```
$ pub get
```

with `Flutter`:

```
$ flutter pub get
```

### 3. Import it

Now in your `Dart` code, you can use:

```dart
import 'package:flutter_step_container/flutter_step_container.dart';
```

# Usage

`StepContainer` is a _Stateful Widget_ that show steps.
Include it in your `build` method like:

```dart
StepContainer(
        finishCallBack: (val) {
          print('callback====$val');
        },
        finishView: Center(
          child: ListView(
            children: List<Widget>.generate(100, (index) => Text('Hi,I\'m Giff $index')),
            shrinkWrap: true,
          ),
        ),
        models: <StepModel>[
          StepModel(
              title: Text('Page one'),
              content: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Name *',
                  )
              ),
          ),
          StepModel(
              title: Text('Page two'),
              content: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.sports),
                    hintText: 'What do people call you before?',
                    labelText: 'I don\'t know',
                  )
              )
          ),
        ],
      )
```
