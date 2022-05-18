var elements = document.getElementsByClassName('status')
for(let i=0;i<elements.length;i++){
    if (elements[i].innerHTML === "Pending") {
        elements[i].classList.add('pending')
    } else if(elements[i].innerHTML === "In Progress") {
        elements[i].classList.add('inprogress')
    }
    else{
        elements[i].classList.add('completed')
    }
}