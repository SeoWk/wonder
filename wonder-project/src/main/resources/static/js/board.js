/*ckEditor*/
var myEditor;

ClassicEditor
	.create( document.querySelector( '#boardContent' ),
	{
		language: "ko",
		  toolbar: [        
			  	'heading', '|',
		        'alignment', '|',
		        'bold', 'italic', 'strikethrough', 'underline', 'subscript', 'superscript', '|',
		        'link', '|',
		        'outdent', 'indent', '|',
		        'insertTable', '|',
		        'uploadImage', '|',
		        'undo', 'redo'
        		]
	/*
	toolbar: {
	    items: [ 'bold', 'italic', '|', 'undo', 'redo', '|', 'numberedList', 'bulletedList' ]
	}
       heading: {
            options: [
                { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' }
            ]
        }
  */
    })

    .then( editor => {
		myEditor = editor;
	})
	
    .catch( error => {
	  console.log( error );
	});
