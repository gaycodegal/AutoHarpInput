map = {}

function keydown(e){
    map[e.key] = e.keyCode;
    console.log(e.key, e.keyCode);
}

function printout(){
    console.log(`{${Object.keys(map).map(x=>`["${x}"]=${map[x]}`).join(',')}}`);
}

document.addEventListener('keydown', keydown);
