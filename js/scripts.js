function get_wallpapers(page) {
    var url = api_url + '?auth=' + auth_key + '&method=featured&page=' + page + '&info_level=3';

    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            var results = JSON.parse(xhr.responseText);

            homePage.getWallpapersFinished(results);
        }
    }

    xhr.send();
}

function search_wallpapers(page, term) {
    var url = api_url + '?auth=' + auth_key + '&method=search&term=' + term + '&page=' + page + '&info_level=3';

    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            var results = JSON.parse(xhr.responseText);

            searchPage.getWallpapersFinished(results);
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
