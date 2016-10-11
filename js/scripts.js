function get_wallpapers(page) {
    var url = api_url + '?auth=' + auth_key + '&method=featured&page=' + page + '&info_level=3';

    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            console.log(xhr.responseText);

            var results = JSON.parse(xhr.responseText);

            var j;
            for (j in results) {
                if (j == 'wallpapers') {
                    var ii = 0;
                    for (var i = 0; i < objLength(results[j]); i++) {
                        var id = results[j][i]['id'];
                        var name = results[j][i]['name'];
                        var image = results[j][i]['url_thumb'];
                        var big_image = results[j][i]['url_image'];
                        wallpapersModel.append({"id":id, "name":name, "image":image, "big_image":big_image});
                        ii++;
                    }
                }
            }
        }
    }

    xhr.send();
}

function objLength(obj){
    var i=0;
    for (var x in obj){
        if(obj.hasOwnProperty(x)){
            i++;
        }
    }
    return i;
}
