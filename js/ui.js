var select;
var comment;
window.onload = function(){
	select = document.querySelectorAll(".bug-form__select")[2];
	comment = document.querySelector(".bug-form__comment");
	select.addEventListener("change", function(){
		comment.style.transform = "scale(1)"
	});
}