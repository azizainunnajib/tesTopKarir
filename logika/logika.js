var array = [6,8,1,4,7,2]

var sum = array.reduce((x, y) => x + y);
var sort = array.sort()
var max = array[array.length-1]
var max3rd = array[array.length - 3]

console.log("jumlah isi array: "+ sum);
console.log("urutan array: "+sort);
console.log('max di array: '+ max);
console.log('max ke-tiga di array: '+max3rd);