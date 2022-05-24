
function change_bg_on_compl_status() {
    var elements = document.getElementsByClassName('compl-status')
    console.log(elements)
    for (let i = 0; i < elements.length; i++) {
        console.log(i)
        if (elements[i].innerHTML.trim() == "Pending") {
            elements[i].classList.add('table-info')
        } else if (elements[i].innerHTML.trim() == "In Progress") {
            elements[i].classList.add('table-warning')
        }
        else {
            elements[i].classList.add('table-success')
        }
    }
}

function change_bg_on_accep_status() {
    var elements = document.getElementsByClassName('accep-status')
    console.log(elements)
    for (let i = 0; i < elements.length; i++) {
        console.log(i)
        if (elements[i].innerHTML.trim() == "Pending") {
            elements[i].classList.add('table-info')
        } else if (elements[i].innerHTML.trim() == "Approved") {
            elements[i].classList.add('table-success')
        }
        else {
            elements[i].classList.add('table-danger')
        }
    }
}
change_bg_on_compl_status()
change_bg_on_accep_status()