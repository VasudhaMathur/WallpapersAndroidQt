function get_wallpapers(page, feed, category, collection) {
    //var url = api_url + '?auth=' + auth_key + '&method=featured&page=' + page + '&info_level=3';

    var url = "";

    var mode_index = filter_by;

    switch (mode_index) {
        case 0:
            url = api_url + '?auth=' + auth_key + '&method=featured&page=' + page + '&info_level=3';
        break;
        case 1:
            url = api_url + '?auth=' + auth_key + '&method=newest&page=' + page + '&info_level=3';
        break;
        case 2:
            url = api_url + '?auth=' + auth_key + '&method=highest_rated&page=' + page + '&info_level=3';
        break;
        case 3:
            url = api_url + '?auth=' + auth_key + '&method=by_views&page=' + page + '&info_level=3';
        break;
        case 4:
            url = api_url + '?auth=' + auth_key + '&method=by_favorites&page=' + page + '&info_level=3';
        break;
    }

    if (category && category != "0") {
        url = api_url + '?auth=' + auth_key + '&method=category&id=' + category + '&page=' + page + '&info_level=3';
    }
    if (collection && collection != "0") {
        url = api_url + '?auth=' + auth_key + '&method=collection&id=' + collection + '&page=' + page + '&info_level=3';
    }

    if (res_width != "" && res_height != "") {
        url = url + '&width=' + res_width + '&height=' + res_height;
    }

    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            var results = JSON.parse(xhr.responseText);

            feed.getWallpapersFinished(results);
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

function get_categories() {
    var url = api_url + '?auth=' + auth_key + '&method=category_list';

    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            var results = JSON.parse(xhr.responseText);

            categoriesPage.getCategoriesFinished(results);
        }
    }

    xhr.send();
}

function get_collections() {
    var url = api_url + '?auth=' + auth_key + '&method=collection_list';

    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            var results = JSON.parse(xhr.responseText);

            collectionsPage.getCollectionsFinished(results);
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
