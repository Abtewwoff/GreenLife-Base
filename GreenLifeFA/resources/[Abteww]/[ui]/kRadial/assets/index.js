document.querySelector('.main').classList.remove('show');
document.querySelector('.main').classList.add('hide');

window.addEventListener('message', function (event) {
    var data = event.data;

    if (data.action === 'show') {
        $('#overflow-box-text').html('');
        document.querySelector('.main').classList.remove('hide');
        document.querySelector('.main').classList.add('show');

        const headerDiv = document.querySelector('.header');

        const spanElement = headerDiv.querySelector('span');

        spanElement.textContent = data.title;

        data.data.forEach(function (item) {
            if (item.bar === true) {
                var boxText = '<div class="box-text"> <span>' + item.title + '</span> <div class="progress-bar" id="progress-bar"></div></div>';
                $('#overflow-box-text').append(boxText);
                
                $(".progress-bar").stop().css({ width: '0px' }).animate({
                    width: '60%',
                }, item.barSecond, 'linear',
                    function () {

                    });
            } else if (item.barValue) {
                var boxText = '<div class="box-text"> <span>' + item.title + '</span> <div class="progress-bar" id="progress-bar"></div></div>';
                $('#overflow-box-text').append(boxText);

                $(".progress-bar").stop().css({ width: item.barValue + '%' })
            } else {
                var boxText = '<div class="box-text"> <span>' + item.title + '</span> <span>' + item.subtitle + '</span> </div>';
                $('#overflow-box-text').append(boxText);
            }
        });
    }

    if (data.action === 'hide') {
        document.querySelector('.main').classList.remove('show');
        document.querySelector('.main').classList.add('hide');
    }
});