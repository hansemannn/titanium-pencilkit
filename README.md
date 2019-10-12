# Titanium iOS 13+ PencilKit

Use the native iOS 13+ PencilKit framework in Axway Titanium.

## Requirements

- [x] Titanium SDK 8.2.0+
- [x] iOS 13+
- [x] Xcode 11+

## Example

```js
var PencilKit = require('ti.pencilkit');

var win = Ti.UI.createWindow({
    title: 'Current canvas'
});
var nav = Ti.UI.createNavigationWindow({
    window: win
});

win.addEventListener('open', function() {
    canvasView.focus();
});

var saveButton = Ti.UI.createButton({
    title: 'Save'
});
saveButton.addEventListener('click', saveCanvas);
win.rightNavButton = saveButton;

var canvasView = PencilKit.createCanvasView();

win.add(canvasView);
nav.open();

function saveCanvas() {
    canvasView.generateImage({
        callback: function(event) {
            var win2 = Ti.UI.createWindow({
                title: 'Saved canvas',
                backgroundColor: '#fff'
            });
            var nav2 = Ti.UI.createNavigationWindow({
                window: win2
            });

            win2.add(Ti.UI.createImageView({
                image: event.image
            }));
            nav2.open({
                modal: true
            });
        }
    })
    }
```

## Author

Hans Knöchel

## License

UNLICENSED

## Copyright

(c) 2019-present by binaries included
