var PencilKit = require('ti.pencilkit');

var file = Ti.Filesystem.getFile(Ti.Filesystem.applicationDataDirectory, 'my_drawing.drawing');

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
    title: 'Save as Image'
});

saveButton.addEventListener('click', exportDrawingAsImage);
win.rightNavButton = saveButton;

var dataButton = Ti.UI.createButton({
    title: 'Export data'
});

dataButton.addEventListener('click', exportDrawingData);
win.leftNavButton = dataButton;

var canvasView = PencilKit.createCanvasView();

if (file.exists()) {
    canvasView.drawing = file.read();
}

/** Canvas view events */

canvasView.addEventListener('begin', function() {
    console.log('Began drawing!');
});

canvasView.addEventListener('change', function() {
    console.log('Changed drawing!');
});

canvasView.addEventListener('end', function() {
    console.log('Ended drawing!');
});

/** Tool picker events */

canvasView.addEventListener('toolPicker:visibilityDidChange', function(event) {
    console.log('toolPicker:visibilityDidChange: ' + event.isVisible);
});

canvasView.addEventListener('toolPicker:selectedToolDidChange', function() {
    console.log('toolPicker:selectedToolDidChange');
});

canvasView.addEventListener('toolPicker:isRulerActiveDidChange', function(event) {
    console.log('toolPicker:isRulerActiveDidChange: ' + event.rulerActive);
});

canvasView.addEventListener('end', function() {
    console.log('toolPicker:framesObscuredDidChange');
});

win.add(canvasView);
nav.open();

function exportDrawingAsImage() {
    canvasView.exportDrawingAsImage({
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
    });
}

function exportDrawingData() {
    // Also possible: Export the current drawing as a blob
    // Note #1: If you keep the drawing opened and change it afterwards,
    // the exported drawing reference will also be updated
    // Note #2: Once you save the data, this demo will reuse it as the initial drawing
    canvasView.exportDrawingData(function(event) {
        file.write(event.data);
        console.log(file.nativePath);
    });
}