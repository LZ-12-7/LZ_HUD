$(() => {
    $('.personal-info-cont').fadeOut(1)
    window.addEventListener('message', (event) => {
        let e = event.data;

        if (e.open) {
            $('.personal-info-cont').fadeIn(1);
        };

        if (e.movehud) {
            $('.container-hud').css('left', '16.2vw');
        } else {
            $('.container-hud').css('left', '.5vw');
        };
    

        if (e.action === "updateHUD"){
            $('.progressbar-vida').css('height', (e.health) + '%');
            $('.progressbar-escudo').css('height', (e.armor) + '%');
            $('.progressbar-hunger').css('height', (e.hunger) + '%');
            $('.progressbar-thirst').css('height', (e.thirst) + '%');
            $('.logo').html(`<img src="${e.logolink}" class="logo">`);
        };

        if (e.action === "updatepj"){
            $('.container-hud').fadeOut(100);
            $('.bienvenida').text("Bienvenido " + (e.name) + "!");
            $('.id-player').text('ID: ' + (e.PlayerId));
            $('.efectivo-amount').text('$' + (e.money));
            $('.banco-amount').text('$' + (e.bank));
            $('.black_money-amount').text('$' + (e.black_money));
            $('.jobandgrade').text("OFICIO: " + (e.job));
            $('.grade').text("GRADO: " + (e.grade));
            $('.salario').text("SALARIO: $" + (e.salary));
        };

        if (Math.round(e.health) >= 70 ) {
            $('.vida').fadeOut(100);
        } else if (Math.round(e.health) < 70 ) {
            $('.vida').fadeIn(100);
        };

        if (Math.round(e.armor) >= 70) {
            $('.escudo').fadeOut(100);
        } else if (Math.round(e.armor) < 70) {
            $('.escudo').fadeIn(100);
        };

        if (Math.round(e.hunger) >= 70) {
            $('.hunger').fadeOut(100);
        } else if (Math.round(e.hunger) < 70) {
            $('.hunger').fadeIn(100);
        };

        if (Math.round(e.thirst) >= 70) {
            $('.thirst').fadeOut(100);
        } else if (Math.round(e.thirst) < 70) {
            $('.thirst').fadeIn(100);
        };

        if (e.action === "InVeh"){ // si la accion es InVeh entonces...
            $('.container-car').show(); // mostrar carhud
            $('.velocidad').text(Math.round(e.kmh) + ""); // cambiar el texto de velocidadact por el mensaje evento kmh
            $('.fuel-p').css('width', Math.round(e.fuel) + "%");  // cambiar el texto de gasolinact por el mensaje evento fuel, y poner % al final
            $('.marcha-text').text(e.gear); // cambiar el texto de marchact por el mensaje evento gear, y poner
        } else if (e.action === "outVeh"){ // si la accion es outVeh entonces...
            $('.container-car').hide(); // ocultar carhud
        }; // fin

        $('#exit-pjinfo').click(() => {
            $('.personal-info-cont').fadeOut(1);
            $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
            $('.container-hud').fadeIn(100);
        });

        $('.aceptar').click(() => {
            $('.personal-info-cont').fadeOut(1);
            $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
            $('.container-hud').fadeIn(100);
        });
    });
    
    document.onkeyup = (e) => {
        if (e.key == 'Escape') {
            $('.personal-info-cont').fadeOut(1);
            $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
            $('.container-hud').fadeIn(100);
        };
    };

});

/* 
    
*/