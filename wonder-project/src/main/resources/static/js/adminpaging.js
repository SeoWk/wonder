/**
 * adminpaging.js
 */
function pageProc(currentPage) {
	$('input[name=currentPage]').val(currentPage);
	$('form[name=frmPage]').submit();
}