/**
 * admin.js
 */
function validate_adminId(id){
	var pattern = new RegExp(/^[a-zA-Z0-9_]+$/g);
	return pattern.test(id);
	/*
	정규식 /^[a-zA-Z0-9_]+$/g
	a에서 z 사이의 문자, A~Z사이의 문자, 0 에서 9사이의 숫자나 _로 시작하거나 끝나야 한다는 의미
	닫기 대괄호(]) 뒤의 + 기호는 이 패턴이 한 번 또는 그 이상 반복된다는 의미
	*/
}