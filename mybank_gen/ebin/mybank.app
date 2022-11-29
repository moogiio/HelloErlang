{application, mybank,
    [
        {description, "A Bank Example"},
        {vsn, "0.1.0"},
        {registered, [
            mybank_atm,
            mybank_sup
        ]},
        {application, [
            kernel,
            stdlib
        ]},
        {mod, {mybank_app, []}},
        {env, []}
    ]
}.