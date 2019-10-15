# Titanium iOS 13+ PencilKit

Use the native iOS 13+ PencilKit framework in Axway Titanium. This module is sponsored by [binaries included](https://binaries-included.net)!

## Requirements

- [x] Titanium SDK 8.2.0+
- [x] iOS 13+
- [x] Xcode 11+

## Example

```js
import PencilKit from 'ti.pencilkit';

const win = Ti.UI.createWindow({
    title: 'Current canvas'
});

const nav = Ti.UI.createNavigationWindow({
    window: win
});

win.addEventListener('open', () => {
    canvasView.focus();
});

const saveButton = Ti.UI.createButton({
    title: 'Save'
});

saveButton.addEventListener('click', saveCanvas);
win.rightNavButton = saveButton;

const canvasView = PencilKit.createCanvasView();

win.add(canvasView);
nav.open();

function saveCanvas() {
    canvasView.generateImage({
        callback: event => {
            const win2 = Ti.UI.createWindow({
                title: 'Saved canvas',
                backgroundColor: '#fff'
            });

            const nav2 = Ti.UI.createNavigationWindow({
                window: win2
            });

            win2.add(Ti.UI.createImageView({
                image: event.image
            }));

            nav2.open({
                modal: true
            });
        }
    });
}
```

## Author

Hans Knöchel

## License

MIT

## Copyright

(c) 2019-present by [binaries included](https://binaries-included.net)
