function take_snapshot(){
    Webcam.snap(function(data_uri) {
        id = $('[id*="_image"]');

        if (id.length) {
            id.val(data_uri);
        }

        document.getElementById('results').innerHTML = '<img src="' + data_uri + '"/>';

        //Agrega el preview de la foto al img-circle en view new_person
        $('#nw_img_prev').attr("src", data_uri);
        $('#ed_img_prev').attr("src", data_uri);
        $('#del_photo_btn').show();
    });
}
$(document).ready(function() {
    if ($("#my_camera").length) {
        Webcam.set({
            width: 320,
            height: 240,
            image_format: 'jpeg',
            jpeg_quality: 90
        });

        Webcam.attach('#my_camera');
    }
});