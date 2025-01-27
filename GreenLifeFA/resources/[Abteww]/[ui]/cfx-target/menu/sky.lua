function _sky()
    Action_Config = {
        Sky = {
            {
                Type = "buttom-submenu",
                Blocked = false,
                Label = "Changer l'heure",
                IsRestricted = true,
                Action = {
                    {
                        'Matin', 
                        function() 
                            ExecuteCommand("time 8 00")
                        end
                    },
                    {
                        'Après-midi', 
                        function() 
                            ExecuteCommand("time 12 00")
                        end
                    },
                    {
                        'Soirée', 
                        function() 
                            ExecuteCommand("time 18 00")
                        end
                    },
                    {
                        'Nuit', 
                        function() 
                            ExecuteCommand("time 22 00")
                        end
                    },
                },
            },
            {
                Type = "buttom-submenu",
                Blocked = false,
                Label = "Changer la météo",
                IsRestricted = true,
                Action = {
                    {
                        'Clear', 
                        function() 
                            ExecuteCommand("weather clear")
                        end
                    },
                    {
                        'Clearing', 
                        function() 
                            ExecuteCommand("weather clearing")
                        end
                    },
                    {
                        'Clouds', 
                        function() 
                            ExecuteCommand("weather clouds")
                        end
                    },
                    {
                        'Extra Sunny', 
                        function() 
                            ExecuteCommand("weather extrasunny")
                        end
                    },
                    {
                        'Foggy', 
                        function() 
                            ExecuteCommand("weather foggy")
                        end
                    },
                    {
                        'Overcast', 
                        function() 
                            ExecuteCommand("weather overcast")
                        end
                    },
                    {
                        'Rain', 
                        function() 
                            ExecuteCommand("weather rain")
                        end
                    },
                    {
                        'Smog', 
                        function() 
                            ExecuteCommand("weather smog")
                        end
                    },
                    {
                        'Thunder', 
                        function() 
                            ExecuteCommand("weather thunder")
                        end
                    },
                    {
                        'Xmas', 
                        function() 
                            ExecuteCommand("weather xmas")
                        end
                    },
                },
            },
        },
    }
end
