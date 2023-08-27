import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imgy/imgy.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  var imageAddress =
      "https://images.unsplash.com/photo-1682685797229-b2930538da47?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80";

  testWidgets(
    'Check Imgy component initial render and behavior',
    (tester) async {
      await mockNetworkImagesFor(() async {
        return tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Imgy(
                src: imageAddress,
                fullSrc: imageAddress,
              ),
            ),
          ),
        );
      });

      //just see image preview

      expect(find.byKey(const Key('imgy_preview_container')), findsOneWidget);
      expect(find.byKey(const Key('imgy_preview_image')), findsOneWidget);

      //can't see full screen because it's hidden

      expect(find.byKey(const Key('imgy_full_screen_container')), findsNothing);
      expect(find.byKey(const Key('imgy_full_screen_image')), findsNothing);

      //tap on image preview to open full screen

      await tester.tap(find.byKey(const Key('imgy_preview_container')));

      await tester.pumpAndSettle();

      //can't see because {enableFullScreen} is false

      expect(find.byKey(const Key('imgy_full_screen_container')), findsNothing);
    },
  );

  testWidgets(
    'Check full screen render and behavior',
    (tester) async {
      await mockNetworkImagesFor(() async {
        return tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                child: Imgy(
                  src: imageAddress,
                  fullSrc: imageAddress,
                  enableFullScreen: true,
                ),
              ),
            ),
          ),
        );
      });

      //tap on image preview to open full screen

      await tester.tap(find.byKey(const Key('imgy_preview_container')));
      await tester.pump();

      //can see full screen because {enableFullScreen} is true

      expect(
          find.byKey(const Key('imgy_full_screen_container')), findsOneWidget);
      expect(find.byKey(const Key('imgy_full_screen_image')), findsOneWidget);

      //check header and buttons

      expect(find.byKey(const Key('imgy_full_screen_header')), findsOneWidget);
      expect(find.byKey(const Key('imgy_full_screen_close')), findsOneWidget);
      expect(find.byKey(const Key('imgy_full_screen_share')), findsOneWidget);
      expect(
          find.byKey(const Key('imgy_full_screen_download')), findsOneWidget);
      expect(find.byKey(const Key('imgy_full_screen_check')), findsNothing);

      //tap on close button to close full screen

      await tester.tap(find.byKey(const Key('imgy_full_screen_close')));
      await tester.pump();

      //can't see full screen because it's hidden

      expect(find.byKey(const Key('imgy_full_screen_container')), findsNothing);
      expect(find.byKey(const Key('imgy_full_screen_image')), findsNothing);
    },
  );

  testWidgets("Check render for asset image", (widgetTester) async {
    await widgetTester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Imgy(
            src: "./example/assets/images/image-example.jpeg",
            fullSrc: "./example/assets/images/image-example.jpeg",
            enableFullScreen: true,
          ),
        ),
      ),
    );

    //just see image preview

    expect(find.byKey(const Key('imgy_preview_container')), findsOneWidget);
    expect(find.byKey(const Key('imgy_preview_asset')), findsOneWidget);

    //tap on image preview to open full screen

    await widgetTester.tap(find.byKey(const Key('imgy_preview_container')));
    await widgetTester.pump();

    //check if cant see download button

    expect(find.byKey(const Key('imgy_full_screen_download')), findsNothing);
  });
}
