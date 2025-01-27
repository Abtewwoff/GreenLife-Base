(() => {
    "use strict";
    var n = {
            426: (n, e, t) => {
                t.d(e, {
                    Z: () => s
                });
                var r = t(81),
                    o = t.n(r),
                    a = t(645),
                    i = t.n(a)()(o());
                i.push([n.id, "body {\n  margin: 0;\n  line-height: normal;\n}\n\n:root {\n  /* fonts */\n  --font-poppins: Poppins;\n\n  /* font sizes */\n  --font-size-xs: 0.625vw;\n\n  /* Colors */\n  --color-gray: rgba(41, 41, 41, 0.51);\n  --color-white: #fff;\n\n  /* Gaps */\n  --gap-8xs: 0.26vw;\n\n  /* Paddings */\n  --padding-8xs: 0.26vw;\n\n  /* Border radiuses */\n  --br-11xs: 0.104vw;\n}\n\n\n.background-icon{\n  width: 100vw;\n  position: relative;\n  height: 56.25vw;\n  object-fit: cover;\n  z-index: 0;\n}\n@keyframes heartbeat {\n  0% {\n    transform: scale(1);\n  }\n  50% {\n    transform: scale(1.3);\n  }\n  100% {\n    transform: scale(1);\n  }\n}\n#ui {\n  display:none;\n}\n.logo-icon {\n  width: 3.125vw;\n  position: absolute;\n  margin: 0 !important;\n  top: 0.573vw;\n  left: 0.573vw;\n  height: 3.125vw;\n  z-index: 1;\n  animation: heartbeat 1s ease-in-out infinite; /* Vous pouvez ajuster la durée de l'animation selon vos préférences */\n}\n\n.logo-time-icon {\n  width: 0.885vw;\n  height: 0.885vw;\n  overflow: hidden;\n  flex-shrink: 0;\n}\n.logo-time-icon,\n.text-time {\n  position: relative;\n}\n.time-main {\n  overflow: hidden;\n  display: flex;\n  flex-direction: row;\n  align-items: center;\n  justify-content: flex-end;\n  gap: var(--gap-8xs);\n}\n.logo-date-icon {\n  width: 0.781vw;\n  position: relative;\n  height: 0.781vw;\n  overflow: hidden;\n  flex-shrink: 0;\n}\n.time-date-main {\n  border-radius: 4px;\n  background-color: var(--color-gray);\n  overflow: hidden;\n  display: flex;\n  flex-direction: row;\n  align-items: center;\n  justify-content: flex-end;\n  padding: var(--padding-8xs);\n  gap: var(--gap-8xs);\n}\n.logo-playrs-icon {\n  width: 0.833vw;\n  position: relative;\n  height: 0.833vw;\n  overflow: hidden;\n  flex-shrink: 0;\n}\n.logo-discord-icon {\n  width: 1.042vw;\n  position: relative;\n  height: 1.042vw;\n  object-fit: cover;\n}\n.background-parent,\n.hud {\n  display: flex;\n  flex-direction: column;\n  justify-content: flex-start;\n}\n.hud {\n  width: 12.604vw;\n  margin: 0 !important;\n  position: absolute;\n  top: 0.781vw;\n  left: 86.25vw;\n  align-items: flex-end;\n  gap: var(--gap-8xs);\n  z-index: 2;\n}\n.background-parent {\n  width: 100%;\n  position: relative;\n  height: 56.25vw;\n  align-items: flex-start;\n  gap: 0.521vw;\n  text-align: center;\n  font-size: var(--font-size-xs);\n  color: var(--color-white);\n  font-family: var(--font-poppins);\n}\n", ""]);
                const s = i
            },
            645: n => {
                n.exports = function(n) {
                    var e = [];
                    return e.toString = function() {
                        return this.map((function(e) {
                            var t = "",
                                r = void 0 !== e[5];
                            return e[4] && (t += "@supports (".concat(e[4], ") {")), e[2] && (t += "@media ".concat(e[2], " {")), r && (t += "@layer".concat(e[5].length > 0 ? " ".concat(e[5]) : "", " {")), t += n(e), r && (t += "}"), e[2] && (t += "}"), e[4] && (t += "}"), t
                        })).join("")
                    }, e.i = function(n, t, r, o, a) {
                        "string" == typeof n && (n = [
                            [null, n, void 0]
                        ]);
                        var i = {};
                        if (r)
                            for (var s = 0; s < this.length; s++) {
                                var c = this[s][0];
                                null != c && (i[c] = !0)
                            }
                        for (var d = 0; d < n.length; d++) {
                            var u = [].concat(n[d]);
                            r && i[u[0]] || (void 0 !== a && (void 0 === u[5] || (u[1] = "@layer".concat(u[5].length > 0 ? " ".concat(u[5]) : "", " {").concat(u[1], "}")), u[5] = a), t && (u[2] ? (u[1] = "@media ".concat(u[2], " {").concat(u[1], "}"), u[2] = t) : u[2] = t), o && (u[4] ? (u[1] = "@supports (".concat(u[4], ") {").concat(u[1], "}"), u[4] = o) : u[4] = "".concat(o)), e.push(u))
                        }
                    }, e
                }
            },
            81: n => {
                n.exports = function(n) {
                    return n[1]
                }
            },
            379: n => {
                var e = [];

                function t(n) {
                    for (var t = -1, r = 0; r < e.length; r++)
                        if (e[r].identifier === n) {
                            t = r;
                            break
                        } return t
                }

                function r(n, r) {
                    for (var a = {}, i = [], s = 0; s < n.length; s++) {
                        var c = n[s],
                            d = r.base ? c[0] + r.base : c[0],
                            u = a[d] || 0,
                            l = "".concat(d, " ").concat(u);
                        a[d] = u + 1;
                        var p = t(l),
                            f = {
                                css: c[1],
                                media: c[2],
                                sourceMap: c[3],
                                supports: c[4],
                                layer: c[5]
                            };
                        if (-1 !== p) e[p].references++, e[p].updater(f);
                        else {
                            var v = o(f, r);
                            r.byIndex = s, e.splice(s, 0, {
                                identifier: l,
                                updater: v,
                                references: 1
                            })
                        }
                        i.push(l)
                    }
                    return i
                }

                function o(n, e) {
                    var t = e.domAPI(e);
                    return t.update(n),
                        function(e) {
                            if (e) {
                                if (e.css === n.css && e.media === n.media && e.sourceMap === n.sourceMap && e.supports === n.supports && e.layer === n.layer) return;
                                t.update(n = e)
                            } else t.remove()
                        }
                }
                n.exports = function(n, o) {
                    var a = r(n = n || [], o = o || {});
                    return function(n) {
                        n = n || [];
                        for (var i = 0; i < a.length; i++) {
                            var s = t(a[i]);
                            e[s].references--
                        }
                        for (var c = r(n, o), d = 0; d < a.length; d++) {
                            var u = t(a[d]);
                            0 === e[u].references && (e[u].updater(), e.splice(u, 1))
                        }
                        a = c
                    }
                }
            },
            569: n => {
                var e = {};
                n.exports = function(n, t) {
                    var r = function(n) {
                        if (void 0 === e[n]) {
                            var t = document.querySelector(n);
                            if (window.HTMLIFrameElement && t instanceof window.HTMLIFrameElement) try {
                                t = t.contentDocument.head
                            } catch (n) {
                                t = null
                            }
                            e[n] = t
                        }
                        return e[n]
                    }(n);
                    if (!r) throw new Error("Couldn't find a style target. This probably means that the value for the 'insert' parameter is invalid.");
                    r.appendChild(t)
                }
            },
            216: n => {
                n.exports = function(n) {
                    var e = document.createElement("style");
                    return n.setAttributes(e, n.attributes), n.insert(e, n.options), e
                }
            },
            565: (n, e, t) => {
                n.exports = function(n) {
                    var e = t.nc;
                    e && n.setAttribute("nonce", e)
                }
            },
            795: n => {
                n.exports = function(n) {
                    if ("undefined" == typeof document) return {
                        update: function() {},
                        remove: function() {}
                    };
                    var e = n.insertStyleElement(n);
                    return {
                        update: function(t) {
                            ! function(n, e, t) {
                                var r = "";
                                t.supports && (r += "@supports (".concat(t.supports, ") {")), t.media && (r += "@media ".concat(t.media, " {"));
                                var o = void 0 !== t.layer;
                                o && (r += "@layer".concat(t.layer.length > 0 ? " ".concat(t.layer) : "", " {")), r += t.css, o && (r += "}"), t.media && (r += "}"), t.supports && (r += "}");
                                var a = t.sourceMap;
                                a && "undefined" != typeof btoa && (r += "\n/*# sourceMappingURL=data:application/json;base64,".concat(btoa(unescape(encodeURIComponent(JSON.stringify(a)))), " */")), e.styleTagTransform(r, n, e.options)
                            }(e, n, t)
                        },
                        remove: function() {
                            ! function(n) {
                                if (null === n.parentNode) return !1;
                                n.parentNode.removeChild(n)
                            }(e)
                        }
                    }
                }
            },
            589: n => {
                n.exports = function(n, e) {
                    if (e.styleSheet) e.styleSheet.cssText = n;
                    else {
                        for (; e.firstChild;) e.removeChild(e.firstChild);
                        e.appendChild(document.createTextNode(n))
                    }
                }
            }
        },
        e = {};

    function t(r) {
        var o = e[r];
        if (void 0 !== o) return o.exports;
        var a = e[r] = {
            id: r,
            exports: {}
        };
        return n[r](a, a.exports, t), a.exports
    }
    t.n = n => {
        var e = n && n.__esModule ? () => n.default : () => n;
        return t.d(e, {
            a: e
        }), e
    }, t.d = (n, e) => {
        for (var r in e) t.o(e, r) && !t.o(n, r) && Object.defineProperty(n, r, {
            enumerable: !0,
            get: e[r]
        })
    }, t.o = (n, e) => Object.prototype.hasOwnProperty.call(n, e), t.nc = void 0, (() => {
        var n = t(379),
            e = t.n(n),
            r = t(795),
            o = t.n(r),
            a = t(569),
            i = t.n(a),
            s = t(565),
            c = t.n(s),
            d = t(216),
            u = t.n(d),
            l = t(589),
            p = t.n(l),
            f = t(426),
            v = {};
        v.styleTagTransform = p(), v.setAttributes = c(), v.insert = i().bind(null, "head"), v.domAPI = o(), v.insertStyleElement = u(), e()(f.Z, v), f.Z && f.Z.locals && f.Z.locals;
        var h = m;

        function m(n, e) {
            var t = g();
            return (m = function(n, e) {
                return t[n -= 321]
            })(n, e)
        }

        function g() {
            var n = ["job_value", "data", "getMonth", "player-id", "setId", "getMinutes", "onlineCount", "7689EBAuvJ", "4902867PwKRew", "value", "5730MxREdH", "132521RJHrAg", "job", "online-count", "show", "job2_value", "3QQTwsc", "http://", "padStart", "action", "411792XKdMOs", "toString", "component", "date", "ready", "hideComponent", "type", "textContent", "hide", "#ui", "/firstactivate", "message", "hideUi", "3541152DwlhNq", "2454392dnaznx", "post", "getElementById", "job_name", "7LUmUgH", "getHours", "2806386QLLCmW", "fadeUi", "innerHTML", "5Whgjyf", "getDate", "heure", "job2"];
            return (g = function() {
                return n
            })()
        }

        function w() {
            var n = m,
                e = new Date;
            return e[n(363)]().toString()[n(342)](2, "0") + ":" + e[n(329)]()[n(345)]()[n(342)](2, "0")
        }! function(n, e) {
            for (var t = m, r = n();;) try {
                if (379980 == -parseInt(t(335)) / 1 + -parseInt(t(344)) / 2 * (-parseInt(t(340)) / 3) + -parseInt(t(358)) / 4 * (parseInt(t(367)) / 5) + -parseInt(t(364)) / 6 + -parseInt(t(362)) / 7 * (-parseInt(t(357)) / 8) + parseInt(t(332)) / 9 + parseInt(t(334)) / 10 * (parseInt(t(331)) / 11)) break;
                r.push(r.shift())
            } catch (n) {
                r.push(r.shift())
            }
        }(g), $((function() {
            var n = m;
            window.addEventListener(n(355), (function(e) {
                var t, r, o, a, i = n,
                    s = e[i(325)];
                s[i(343)] === i(328) ? (o = s[i(333)], a = m, document.getElementById(a(327)).innerHTML = o) : s[i(350)] === i(337) ? (t = s[i(330)], r = m, document.getElementById("online-count")[r(366)] = t + "/300") : s.action === i(356) ? !0 === s[i(333)] ? $("#ui")[i(352)]() : $(i(353))[i(338)]() : s[i(343)] === i(365) ? !0 === s[i(333)] ? $(i(353)).hide(500) : $("#ui")[i(338)](500) : s.action === i(349) ? !0 === s.value ? $("#" + s.component)[i(352)]() : $("#" + s[i(346)])[i(338)]() : "setInfos" === s[i(343)] && ($[i(359)](i(341) + GetParentResourceName() + i(354)), $(i(353))[i(338)](), s[i(361)] == i(336) && (document.getElementById(i(336))[i(366)] = s[i(324)]), s.job2_name == i(323) && (document[i(360)]("job2")[i(366)] = s[i(339)]))
            }))
        })), $(document)[h(348)]((function() {
            var n, e, t = h;
            document[t(360)](t(322)).textContent = w(), document[t(360)](t(347))[t(351)] = (n = m, (e = new Date)[n(321)]().toString().padStart(2, "0") + "." + (e[n(326)]() + 1).toString().padStart(2, "0") + "." + e.getFullYear()), setInterval((function() {
                var n = t;
                document[n(360)](n(322))[n(351)] = w()
            }), 1e3)
        }))
    })()
})();