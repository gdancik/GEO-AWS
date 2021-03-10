
var x;
$( document ).ready(function() {

    div = document.createElement('div');
    div.id = 'startup';
    div.style.width = "100%";
    div.style.height = "100%";
    div.style.backgroundColor = 'white'; //rgb(0,38,73)';
        //"<div id = 'startup2' style = 'position:fixed;top:40%; width:100%; color:white;'>" + 
    //                "<h2 style = 'width:80%;margin-left:auto;margin-right:auto;'> Please wait... </h2></center> </div>";
    div.innerHTML = '<div class=\"progress\" style=\"height:25px !important; position:absolute; top:40%; width:90%; margin-left:5%;\"><div class=\"progress-bar progress-bar-striped active\" role=\"progressbar\" aria-valuenow=\"40\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width:100%\">' +
         '<span id=\"bar-text\">Loading <i>shinyGEO</i>, please wait ...</span></div></div>';
    
    div.style.position = 'fixed';
    div.style.top = '1%';
    div.style.zIndex = 900;

    document.body.appendChild(div);


$('#manuBtn').click(function(){
	x = 1;
        $('#autogenModal').modal('hide').one('hidden.bs.modal',function(){
                $('#summaryBSModal').modal('show');
        });
});

$('#gBack').click(function(x){

	if(window.x == '1'){
	   $('#summaryBSModal').modal('hide').one('hidden.bs.modal',function(){
		$('#autogenModal').modal('show');
		});
	}
	else{
	  $('#summaryBSModal').modal('hide');
	}
});

$('#downloadSet').click(function(){
   $('#ioAlert').children('div').children('p').html("<p><strong>Your dataset  has been downloaded!</strong> Edit your data then save your work and upload the dataset.</p>")

});

$('.nav-tabs > li:nth-child(2)').click(function(event){
	$('.progress-bar').css("width",0);

});
$('.nav-tabs > li:nth-child(1)').click(function(event){
	$('.progress-bar').css("width",0);


});


$('#selectGenes').parent().click(function(event){
$('#autoAnalysis').removeAttr("disabled");

});

$('#autoAnalysis').click(function(event){
$('#formatDEButton2').removeAttr("disabled");

});


//var $holder = $('#platLink').detach();
//#$('#summaryBSModal').next().next().children().children().children().first().after($holder);

});
