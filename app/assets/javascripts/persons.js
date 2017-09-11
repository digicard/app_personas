$(document).on('turbolinks:load', function() {
  	
  	$('#del_photo_btn').hide();
  	var ed_original_img = $('#ed_img_prev').attr('src');
  	var nw_original_img = $('#nw_img_prev').attr('src');
  	//console.log(original_img);

	//Preview de foto 
  	function readURL(input) {
    	if (input.files && input.files[0]) {
    		var reader = new FileReader();

      		reader.onload = function (e) {
        		$('#nw_img_prev').attr('src', e.target.result);
        		$('#ed_img_prev').attr('src', e.target.result);
      		}
      		reader.readAsDataURL(input.files[0]);
    	}
  	}

 	$("#avatar-upload").change(function(){
    	$('#nw_img_prev').removeClass('hidden');
    	$('#ed_img_prev').removeClass('hidden');
    	$('#del_photo_btn').show();
    	readURL(this);
  	});

 	//Elimina la foto seleccionada o tomada con la webcam y vuelve a la original
  	$('#del_photo_btn').on('click', function(){
  		//Setea a nulo la variable que tiene la ruta del archivo seleccionado
  		$('#avatar-upload').val(null);
  		//Setea a nulo la variable que tiene la foto tomada con la webcam
  		$('#person_image').val("");
  		$('#ed_img_prev').attr('src', ed_original_img);
  		$('#nw_img_prev').attr('src', nw_original_img);
    	$('#del_photo_btn').hide();
  	})

  //Por defecto cargar persona nueva no se muestra
  $('#div_new_person_data').hide();
 	//Checkbox persona nueva - Cambio entre forms de show_person y new_person
	$('#pn_chkbox').change(function(){
		if($(this).prop('checked')){
			$('#div_show_person').hide();
			$('#div_new_person_data').show();
			$('.js-example-placeholder-single').prop('disabled', true);
			$('#submitca').hide();
			//$('#submitca').prop('disabled', true);
		}else{
			$('#div_show_person').show();
			$('#div_new_person_data').hide();
			$('.js-example-placeholder-single').prop('disabled', false);
			$('#submitca').show();
			//$('#submitca').prop('disabled', false);
		}
	})

	//Habilita buscador de personas
	$(".js-example-placeholder-single").select2({
		placeholder: "Seleccionar persona",
	  allowClear: true
	});

	//Deshabilita boton submit CA hasta que se seleccione una persona
	$('#submitca').prop('disabled', true);
	
	$('.js-example-placeholder-single').on('change', function(e) {
		//Habilita boton submit CA
		$('#submitca').prop('disabled', false);

		pid = $('.js-example-placeholder-single option:selected').val();

		$.ajax({
      		url: "/persons/show_person/",
      		type: "get",
      		data: {pid},
      		success: function(e){
        		console.log('Retrieved data successfully');
        		$('#apellido_inp').val(e.Apellido);
        		$('#nombre_inp').val(e.Nombre);
        		//$('#tdoc_inp').val(e.TDoc);
            switch(e.TDoc) {
            case "DNI":
              $('#tdoc_inp').val("Documento Nacional de Identidad");
              break;
            case "LE":
              $('#tdoc_inp').val("Libreta de Enrolamiento");
              break;
            case "LC":
              $('#tdoc_inp').val("Libreta Civica");
              break;
            case "CI":
              $('#tdoc_inp').val("Cedula de Identidad");
              break;
            } 
        		$('#ndoc_inp').val(e.NDoc);
        		if (e.Habil == true)
        			$('#estado_inp').val("Habilitado");
        		else
        			$('#estado_inp').val("Deshabilitado");
        		if (e.Foto != null)
        			$('#img_previw').attr("src", "data:image/jpeg;base64," + e.Foto);
        		else
        			$('#img_previw').attr("src", "/assets/default_avatar.jpg");
        		$('#cuil_inp').val(e.CUIL);
      		},
      		error:function(xhr, ajaxOptions, thrownError) {
        		alert(xhr.status);
        		alert(xhr.responseText);
      		}
    	});
	})

});

//new.html.slim
/*
$('#new_nav_tabs li.disabled > a[data-toggle=tab]').on('turbolinks:load', 'click', function(e) {
	e.preventDefault();
    e.stopImmediatePropagation();
});


$(document).on('turbolinks:load', function() {
	$(".js-example-placeholder-single").select2({
		placeholder: "Seleccione una persona",
	  	allowClear: true
	});

	//Deshabilita boton submit CA hasta que se seleccione una persona
	$('#submitca').prop('disabled', true);
	
	$('.js-example-placeholder-single').on('change', function(e) {
		//Habilita boton submit
		$('#submitca').prop('disabled', false);

		pid = $('.js-example-placeholder-single option:selected').val();

		$.ajax({
      		url: "/persons/show_person/",
      		type: "get",
      		data: {pid},
      		success: function(e){
        		console.log('Retrieved data successfully');
        		$('#apellido_inp').val(e.Apellido);
        		$('#nombre_inp').val(e.Nombre);
        		$('#tdoc_inp').val(e.TDoc);
        		$('#ndoc_inp').val(e.NDoc);
        		if (e.Habil == true)
        			$('#estado_inp').val("Habilitado");
        		else
        			$('#estado_inp').val("Deshabilitado");
        		if (e.Foto != null)
        			$('#img_previw').attr("src", "data:image/jpeg;base64," + e.Foto);
        		else
        			$('#img_previw').attr("src", "/assets/default_avatar.png");
        		$('#cuil_inp').val(e.CUIL);
      		},
      		error:function(xhr, ajaxOptions, thrownError) {
        		alert(xhr.status);
        		alert(xhr.responseText);
      		}
    	});
	})

	//Validaciones
	/*var npd_Apellido = document.getElementById('#npd_Apellido');
	var npd_Nombre = document.getElementById('#npd_Nombre');
	var npd_TDoc = document.getElementById('#npd_NDoc');
	npd_Apellido.addEventListener("input", function (event) {
  		if (npd_Apellido.validity.typeMismatch) {
    		npd_Apellido.setCustomValidity("I expect an e-mail, darling!");
  		} else {
    		npd_Apellido.setCustomValidity("");
  		}
  	});

	npd_Nombre.addEventListener("input", function (event) {
  		if (npd_Nombre.validity.typeMismatch) {
    		npd_Nombre.setCustomValidity("I expect an e-mail, darling!");
  		} else {
    		npd_Nombre.setCustomValidity("");
  		}
  	});

  	npd_TDoc.addEventListener("input", function (event) {
  		if (npd_TDoc.validity.typeMismatch) {
    		npd_TDoc.setCustomValidity("Documento solo acepta números");
  		} else {
    		npd_TDoc.setCustomValidity("");
  		}
  	});

});*/

/*
$(document).on('turbolinks:load', function(){
	$('#btn_save').on('click', function(){
	    var apellido = $('#napellido').val();
	    var nombre = $('#nnombre').val();
	    var tdoc = $('#ntdoc').val();
	    var ndoc = $('#nndoc').val();
	    var cuil = $('#ncuil1').val() + $('#ncuil2').val() + $('#ncuil3').val();
	    var estado = 1;
	    var d = new Date();
	    var fecha = d.getDate() + '/' + (d.getMonth() + 1) + '/' + d.getFullYear();
	    var contacto = $('#ncontacto').val();
	    var categoria = $('#ncateg').val();

	    switch (tdoc){
	    case '2':
	      tdoc = 'LE';
	      break;
	    case '3':
	      tdoc = 'LC';
	      break;
	    case '4':
	      tdoc = 'CI';
	      break;
	    default:
	      tdoc = 'DNI';
	  	}

	  	if ($('#radio2').checked)
	  		estado = 0

	  	switch (categoria){
	  	case '2':
	  		categoria = 2;
	  		break;
	  	case '3':
	  		categoria = 3;
	  		break;
	  	case '4':
	  		categoria = 4;
	  		break;
	  	case '5':
	  		categoria = 5;
	  		break;
	  	default:
	  		categoria = 1;
	  	}

	  	//console.log(apellido, tdoc, estado, categoria);

	  	$.ajax({
      		url: "/persons/"+"?apellido="+apellido+"&nombre="+nombre+"&tdoc="+tdoc+"&ndoc="+ndoc+"&cuil="+cuil+"&estado="+estado+"&fecha="+fecha+"&contacto="+contacto+"&categoria="+categoria,
      		type: "post",
      		data: {apellido, nombre},
      		success: function(){
        		alert('Saved Successfully');
      		},
      		error:function(xhr, ajaxOptions, thrownError) {
        		alert(xhr.status);
        		alert(xhr.responseText);
      		}
    	});

	  	
  	});


  $('#btn_cancel').on ('click', function(){
  	flush();
  });

  function flush(){
  		$('#napellido').val("")
	    $('#nnombre').val("")
	    $('#ntdoc').val("Documento Nacional de Identidad")
	    $('#nndoc').val("")
	    $('#ncuil1').val("")
	    $('#ncuil2').val("")
	    $('#ncuil3').val("")
	    $('#radio1').prop("checked", true)
	    $('#ncontacto').val("")
	    $('#ncateg').val("Empleado")
  }

});
*/
