function playClickSound() {
    var audio = document.getElementById("clickaudio");
    audio.volume = 0.1;
    audio.play();
}

$(document).ready(function(){
    // Hide/show ui function.
    function display(bool) {
        if (bool) {
            $("#overlay").show();
        } else {
            $("#overlay").hide();
        }
    }

    window.addEventListener('message', function(event) {
        if (event.data.type === "open")
            display(event.data.status)
    });

    $("#DefaultAim").click(function() {
        playClickSound();
        $.post('https://fb_weaponanimation/select', JSON.stringify({ selected: 1 }));
    })
    $("#GangsterAim").click(function() {
        playClickSound();
        $.post('https://fb_weaponanimation/select', JSON.stringify({ selected: 2 }));
    })
    $("#HillBillyAim").click(function() {
        playClickSound();
        $.post('https://fb_weaponanimation/select', JSON.stringify({ selected: 3 }));
    })

    $("#DefaultHolster").click(function() {
        playClickSound();
        $.post('https://fb_weaponanimation/select', JSON.stringify({ selected: 4 }));
    })
    $("#BackHolster").click(function() {
        playClickSound();
        $.post('https://fb_weaponanimation/select', JSON.stringify({ selected: 5 }));
    })
    $("#CopHolster").click(function() {
        playClickSound();
        $.post('https://fb_weaponanimation/select', JSON.stringify({ selected: 6 }));
    })

    $("#FrontHolster").click(function() {
        playClickSound();
        $.post('https://fb_weaponanimation/select', JSON.stringify({ selected: 7 }));
    })
    $("#FrontAgressiveHolster").click(function() {
        playClickSound();
        $.post('https://fb_weaponanimation/select', JSON.stringify({ selected: 8 }));
    })
    $("#LegHolster").click(function() {
        playClickSound();
        $.post('https://fb_weaponanimation/select', JSON.stringify({ selected: 9 }));
    })

    document.onkeyup = function(data) {
        if (data.which == 27)
            $.post('https://fb_weaponanimation/close', JSON.stringify({}));
    };
});