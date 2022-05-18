console.log("custom.js loaded")
function change_bg_on_status() {
    var elements = document.getElementsByClassName('status')
    console.log(elements)
    for (let i = 0; i < elements.length; i++) {
        console.log(i)
        if (elements[i].innerHTML.trim() == "Pending") {
            elements[i].classList.add('pending')
        } else if (elements[i].innerHTML.trim() == "In Progress") {
            elements[i].classList.add('inprogress')
        }
        else {
            elements[i].classList.add('completed')
        }
    }
}

change_bg_on_status()
