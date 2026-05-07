<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HMS_LOGIN.aspx.cs" Inherits="HMS_SYSTEM_29.HMS_LOGIN" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MediCore HMS — Secure Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet" />
       <style>
        /* ── Reset & Root ──────────────────────────────── */
        *, *::before, *::after {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --navy: #0b1e3d;
            --navy-mid: #112952;
            --navy-glow: #173670;
            --teal: #00b4a2;
            --teal-lite: #1dd9c5;
            --teal-glow: rgba(0,180,162,.35);
            --gold: #c9a84c;
            --white: #f4f7fb;
            --muted: #8fa5c5;
            --error: #e05e5e;
            --card-bg: rgba(11,30,61,.82);
            --border: rgba(0,180,162,.22);
            --radius: 14px;
            /*--font-head: 'Playfair Display', Georgia, serif;*/
            --font-body: 'DM Sans', sans-serif;
        }

        html, body {
            height: 100%;
            font-family: var(--font-body);
            background: var(--navy);
            color: var(--white);
            overflow-x: hidden;
            overflow-y: auto; 
        }

        /* ── Animated background canvas ───────────────── */
        #bg-canvas {
            position: fixed;
            inset: 0;
            z-index: 0;
        }

        /* ── Gradient overlay ──────────────────────────── */
        .overlay {
            position: fixed;
            inset: 0;
            z-index: 1;
            background: radial-gradient(ellipse 80% 80% at 50% 50%, rgba(17,41,82,.55) 0%, rgba(11,30,61,.97) 70%);
        }

        /* ── Page wrapper ──────────────────────────────── */
        .page {
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 24px;
        }

        /* ── Card ──────────────────────────────────────── */
        .card {
            width: 100%;
            max-width: 460px;
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 52px 48px 44px;
            backdrop-filter: blur(22px) saturate(1.4);
            box-shadow: 0 0 0 1px rgba(0,180,162,.08), 0 32px 80px rgba(0,0,0,.55), 0 0 60px rgba(0,180,162,.07);
            animation: cardIn .9s cubic-bezier(.22,1,.36,1) both;
        }

        @keyframes cardIn {
            from {
                opacity: 0;
                transform: translateY(36px) scale(.97);
            }

            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* ── Logo row ──────────────────────────────────── */
        .logo-row {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 8px;
            animation: fadeUp .7s .15s cubic-bezier(.22,1,.36,1) both;
        }

        .logo-icon {
            width: 46px;
            height: 46px;
            flex-shrink: 0;
            background: linear-gradient(135deg, var(--teal), #008c7e);
            border-radius: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 18px var(--teal-glow);
        }

            .logo-icon svg {
                width: 26px;
                height: 26px;
                fill: #fff;
            }

        .logo-text {
            font-family: var(--font-head);
            font-size: 1.55rem;
            font-weight: 700;
            letter-spacing: .5px;
            background: linear-gradient(90deg, var(--white) 0%, var(--teal-lite) 100%);
            /*-webkit-background-clip: text;*/
            -webkit-text-fill-color: transparent;
        }

        /* ── Divider line ──────────────────────────────── */
        .divider {
            height: 1px;
            width: 100%;
            background: linear-gradient(90deg, transparent, var(--border), transparent);
            margin: 18px 0 28px;
            animation: fadeUp .7s .2s cubic-bezier(.22,1,.36,1) both;
        }

        /* ── Heading ───────────────────────────────────── */
        .heading {
            font-family: var(--font-head);
            font-size: 1.65rem;
            font-weight: 600;
            line-height: 1.25;
            margin-bottom: 6px;
            animation: fadeUp .7s .25s cubic-bezier(.22,1,.36,1) both;
        }

        .sub {
            font-size: .85rem;
            color: var(--muted);
            font-weight: 300;
            margin-bottom: 32px;
            letter-spacing: .2px;
            animation: fadeUp .7s .3s cubic-bezier(.22,1,.36,1) both;
        }

        /* ── Form fields ───────────────────────────────── */
        .field {
            position: relative;
            margin-bottom: 20px;
            animation: fadeUp .7s calc(.35s + var(--d,0s)) cubic-bezier(.22,1,.36,1) both;
        }

            .field:nth-child(2) {
                --d: .05s;
            }

            .field:nth-child(3) {
                --d: .10s;
            }

            .field label {
                display: block;
                font-size: .78rem;
                font-weight: 500;
                color: var(--muted);
                margin-bottom: 8px;
                letter-spacing: .8px;
                text-transform: uppercase;
            }

            .field .input-wrap {
                position: relative;
            }

            .field .icon {
                position: absolute;
                left: 14px;
                top: 50%;
                transform: translateY(-50%);
                width: 18px;
                height: 18px;
                opacity: .5;
                pointer-events: none;
                transition: opacity .25s;
            }

            /* ASP.NET TextBox rendered as <input> */
            .field input[type=text],
            .field input[type=password],
            .field select {
                width: 100%;
                padding: 13px 14px 13px 42px;
                background: rgba(255,255,255,.05);
                border: 1px solid rgba(143,165,197,.2);
                border-radius: 9px;
                color: var(--white);
                font-family: var(--font-body);
                font-size: .95rem;
                outline: none;
                transition: border-color .3s, background .3s, box-shadow .3s;
            }

            .field input::placeholder {
                color: rgba(143,165,197,.4);
            }

            .field input:focus,
            .field select:focus {
                border-color: var(--teal);
                background: rgba(0,180,162,.06);
                box-shadow: 0 0 0 3px rgba(0,180,162,.15);
            }

                .field input:focus ~ .icon,
                .field .input-wrap:focus-within .icon {
                    opacity: 1;
                }

            /* Role select */
            .field select {
                appearance: none;
                -webkit-appearance: none;
                cursor: pointer;
                padding-right: 36px;
            }

                .field select option {
                    background: var(--navy-mid);
                    color: var(--white);
                }

        .select-arrow {
            position: absolute;
            right: 13px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
            opacity: .5;
        }

        /* ── Remember row ──────────────────────────────── */
        .row-meta {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 28px;
            font-size: .83rem;
            animation: fadeUp .7s .5s cubic-bezier(.22,1,.36,1) both;
        }

        .check-wrap {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

            .check-wrap input[type=checkbox] {
                width: 16px;
                height: 16px;
                accent-color: var(--teal);
                cursor: pointer;
            }

            .check-wrap span {
                color: var(--muted);
            }

        .forgot {
            color: var(--teal);
            text-decoration: none;
            font-weight: 500;
            transition: color .2s;
        }

            .forgot:hover {
                color: var(--teal-lite);
            }

        /* ── Fancy button ──────────────────────────────── */
        .btn-wrap {
            position: relative;
            animation: fadeUp .7s .55s cubic-bezier(.22,1,.36,1) both;
        }

            /* The glow halo behind the button */
            .btn-wrap::before {
                content: '';
                position: absolute;
                inset: -3px;
                border-radius: 13px;
                background: linear-gradient(135deg, var(--teal), #006e64, var(--gold), var(--teal));
                background-size: 300% 300%;
                animation: gradShift 4s ease infinite;
                filter: blur(8px);
                opacity: 0;
                transition: opacity .35s;
                z-index: 0;
            }

            .btn-wrap:hover::before {
                opacity: .7;
            }

        @keyframes gradShift {
            0% {
                background-position: 0% 50%;
            }

            50% {
                background-position: 100% 50%;
            }

            100% {
                background-position: 0% 50%;
            }
        }

        /* ASP.NET Button rendered as <input type=submit> */
        .btn-wrap input[type=submit],
        .btn-wrap button {
            position: relative;
            z-index: 1;
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, var(--teal) 0%, #008c7e 100%);
            border: none;
            border-radius: 10px;
            color: #fff;
            font-family: var(--font-body);
            font-size: .97rem;
            font-weight: 600;
            letter-spacing: .6px;
            cursor: pointer;
            overflow: hidden;
            transition: transform .18s, box-shadow .3s;
            box-shadow: 0 6px 24px rgba(0,180,162,.3);
        }

            .btn-wrap input[type=submit]:hover,
            .btn-wrap button:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 36px rgba(0,180,162,.45);
            }

            .btn-wrap input[type=submit]:active,
            .btn-wrap button:active {
                transform: translateY(0);
            }

        /* Ripple */
        .ripple {
            position: absolute;
            border-radius: 50%;
            background: rgba(255,255,255,.3);
            transform: scale(0);
            animation: rippleAnim .6s linear;
            pointer-events: none;
        }

        @keyframes rippleAnim {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }

        /* ── Validation / Error label ──────────────────── */
        .error-msg {
            display: block;
            margin-top: 16px;
            font-size: .83rem;
            color: var(--error);
            text-align: center;
            min-height: 20px;
            animation: fadeUp .4s ease both;
        }

        /* ── Footer strip ──────────────────────────────── */
        .card-footer {
            margin-top: 28px;
            padding-top: 20px;
            border-top: 1px solid rgba(143,165,197,.1);
            text-align: center;
            font-size: .78rem;
            color: var(--muted);
            letter-spacing: .3px;
            animation: fadeUp .7s .65s cubic-bezier(.22,1,.36,1) both;
        }

            .card-footer strong {
                color: var(--teal);
            }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(18px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* ── Floating cross decorations ────────────────── */
        .deco {
            position: fixed;
            z-index: 1;
            pointer-events: none;
            opacity: .04;
            animation: floatDeco 14s ease-in-out infinite;
        }

            .deco svg {
                fill: var(--teal);
            }

            .deco:nth-child(1) {
                top: 8%;
                left: 6%;
                width: 70px;
                animation-duration: 16s;
            }

            .deco:nth-child(2) {
                top: 70%;
                left: 88%;
                width: 50px;
                animation-delay: -5s;
            }

            .deco:nth-child(3) {
                top: 40%;
                left: 2%;
                width: 35px;
                animation-delay: -9s;
                animation-duration: 12s;
            }

            .deco:nth-child(4) {
                top: 15%;
                left: 85%;
                width: 60px;
                animation-delay: -3s;
            }

        @keyframes floatDeco {
            0%,100% {
                transform: translateY(0) rotate(0deg);
            }

            50% {
                transform: translateY(-18px) rotate(8deg);
            }
        }
    </style>
</head>
<body>
    
        <div>
            <!-- Animated particle background -->
            <canvas id="bg-canvas"></canvas>
            <div class="overlay"></div>

            <!-- Floating medical cross decorations -->
            <div class="deco">
                <svg viewBox="0 0 40 40">
                    <rect x="15" y="0" width="10" height="40" />
                    <rect x="0" y="15" width="40" height="10" />
                </svg></div>
            <div class="deco">
                <svg viewBox="0 0 40 40">
                    <rect x="15" y="0" width="10" height="40" />
                    <rect x="0" y="15" width="40" height="10" />
                </svg></div>
            <div class="deco">
                <svg viewBox="0 0 40 40">
                    <rect x="15" y="0" width="10" height="40" />
                    <rect x="0" y="15" width="40" height="10" />
                </svg></div>
            <div class="deco">
                <svg viewBox="0 0 40 40">
                    <rect x="15" y="0" width="10" height="40" />
                    <rect x="0" y="15" width="40" height="10" />
                </svg></div>

            <div class="page">
                <div class="card">

                    <!-- Logo -->
                    <div class="logo-row">
                        <div class="logo-icon">
                            <svg viewBox="0 0 40 40">
                                <rect x="15" y="4" width="10" height="32" />
                                <rect x="4" y="15" width="32" height="10" />
                            </svg>
                        </div>
                        <span class="logo-text">MediCore</span></div>
                    <div class="divider"></div>

                    <!-- Heading -->
                    <p class="heading">Secure Staff Portal</p>
                    <p class="sub">Hospital Management &amp; Information System</p>

                    <!-- ASP.NET Web Form -->
                    <form id="form2" runat="server" autocomplete="off">

                        <!-- Employee ID -->
                        <div class="field">
                            <label for="txtEmployeeId">Employee Mobile</label>
                            <div class="input-wrap">
                                <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                                    <circle cx="12" cy="7" r="4" />
                                </svg>
                                <asp:TextBox
                                    ID="txtEmployeeMobile"
                                    runat="server"
                                    TextMode="SingleLine"
                                    MaxLength="14"
                                    placeholder="Mobile Number"
                                    CssClass="" />
                            </div>
                            <asp:RequiredFieldValidator
                                ID="rfvEmployeeMobile"
                                runat="server"
                                ControlToValidate="txtEmployeeMobile"
                                ErrorMessage="Employee Mobile No is required."
                                Display="Dynamic"
                                ForeColor=""
                                CssClass="error-msg" />
                        </div>

                        <!-- Password -->
                        <div class="field">
                            <label for="txtPassword">Password</label>
                            <div class="input-wrap">
                                <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
                                    <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                                </svg>
                                <asp:TextBox
                                    ID="txtPassword"
                                    runat="server"
                                    TextMode="Password"
                                    MaxLength="64"
                                    placeholder="Enter your password" />
                            </div>
                            <asp:RequiredFieldValidator
                                ID="rfvPassword"
                                runat="server"
                                ControlToValidate="txtPassword"
                                ErrorMessage="Password is required."
                                Display="Dynamic"
                                ForeColor=""
                                CssClass="error-msg" />
                        </div>

                        <!-- Role / Department -->
                        <div class="field">
                            <label for="ddlRole">Department / Role</label>
                            <div class="input-wrap">
                                <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z" />
                                    <polyline points="9 22 9 12 15 12 15 22" />
                                </svg>
                                <asp:DropDownList ID="ddlRole" runat="server" CssClass="">
                                    <asp:ListItem Value="" Text="— Select Department —" />
                                    <asp:ListItem Value="Administration" Text="Administration" />
                                    <asp:ListItem Value="Physician / Doctor" Text="Physician / Doctor" />
                                    <asp:ListItem Value="Nursing Staff" Text="Nursing Staff" />
                                    <asp:ListItem Value="Pharmacy" Text="Pharmacy" />
                                    <asp:ListItem Value="Laboratory" Text="Laboratory" />
                                    <asp:ListItem Value="Radiology" Text="Radiology" />
                                    <asp:ListItem Value="Billing &amp; Finance" Text="Billing &amp; Finance" />
                                    <asp:ListItem Value="IT Department" Text="IT Department" />
                                </asp:DropDownList>
                                <svg class="select-arrow" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="2" width="14" height="14">
                                    <polyline points="4 6 8 10 12 6" />
                                </svg>
                            </div>
                            <asp:RequiredFieldValidator
                                ID="rfvRole"
                                runat="server"
                                ControlToValidate="ddlRole"
                                InitialValue=""
                                ErrorMessage="Please select your department."
                                Display="Dynamic"
                                ForeColor=""
                                CssClass="error-msg" />
                        </div>

                        <!-- Remember me + Forgot password -->
                        <div class="row-meta">
                            <label class="check-wrap">
                                <asp:CheckBox ID="chkRemember" runat="server" />
                                <span>Keep me signed in</span>
                            </label>
                            <asp:HyperLink ID="lnkForgot" runat="server"
                                NavigateUrl="~/ForgotPassword.aspx"
                                CssClass="forgot">Forgot password?</asp:HyperLink>
                        </div>

                        <!-- Login Button -->
                        <div class="btn-wrap" id="btnWrap">
                            <asp:Button
                                ID="btnLogin"
                                runat="server"
                                Text="Sign In to Portal"
                                OnClick="btnLogin_Click"
                                ValidationGroup=""
                                UseSubmitBehavior="true"  />
                        </div>

                        <!-- Server-side message label -->
                        <asp:Label
                            ID="lblMessage"
                            runat="server"
                            Text=""
                            CssClass="error-msg" />

                    </form>
                    <!-- /form1 -->

                    <!-- Footer -->
                    <div class="card-footer">
                        <strong>MediCore Hospital Management System</strong><br />
                        &copy; 2025 &nbsp;·&nbsp; All access is monitored &amp; recorded &nbsp;·&nbsp; v4.2.1
                    </div>

                </div>
                <!-- /card -->
            </div>
            <!-- /page -->

        </div>
   
    <script>
        /* ═══ Canvas particle network ═══════════════════ */
        (function () {
            const canvas = document.getElementById('bg-canvas');
            const ctx = canvas.getContext('2d');
            let W, H, particles = [], RAF;
            const COUNT = 72, MAX_DIST = 130;

            function resize() {
                W = canvas.width = window.innerWidth;
                H = canvas.height = window.innerHeight;
            }
            window.addEventListener('resize', resize);
            resize();

            function Particle() {
                this.x = Math.random() * W;
                this.y = Math.random() * H;
                this.vx = (Math.random() - .5) * .35;
                this.vy = (Math.random() - .5) * .35;
                this.r = Math.random() * 1.8 + .4;
            }

            for (let i = 0; i < COUNT; i++) particles.push(new Particle());

            function draw() {
                ctx.clearRect(0, 0, W, H);

                // connections
                for (let i = 0; i < COUNT; i++) {
                    for (let j = i + 1; j < COUNT; j++) {
                        const dx = particles[i].x - particles[j].x;
                        const dy = particles[i].y - particles[j].y;
                        const d = Math.sqrt(dx * dx + dy * dy);
                        if (d < MAX_DIST) {
                            ctx.beginPath();
                            ctx.moveTo(particles[i].x, particles[i].y);
                            ctx.lineTo(particles[j].x, particles[j].y);
                            ctx.strokeStyle = `rgba(0,180,162,${(1 - d / MAX_DIST) * .18})`;
                            ctx.lineWidth = .8;
                            ctx.stroke();
                        }
                    }
                }

                // dots
                particles.forEach(p => {
                    ctx.beginPath();
                    ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
                    ctx.fillStyle = 'rgba(0,180,162,.55)';
                    ctx.fill();
                    p.x += p.vx; p.y += p.vy;
                    if (p.x < 0 || p.x > W) p.vx *= -1;
                    if (p.y < 0 || p.y > H) p.vy *= -1;
                });

                RAF = requestAnimationFrame(draw);
            }
            draw();
        })();

        /* ═══ Ripple on button click ══════════════════════ */
        (function () {
            const wrap = document.getElementById('btnWrap');
            if (!wrap) return;
            const btn = wrap.querySelector('input[type=submit], button');
            if (!btn) return;
            btn.addEventListener('click', function (e) {
                const r = document.createElement('span');
                r.classList.add('ripple');
                const rect = btn.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                r.style.cssText = `
        width:${size}px; height:${size}px;
        left:${e.clientX - rect.left - size / 2}px;
        top:${e.clientY - rect.top - size / 2}px;
      `;
                btn.appendChild(r);
                setTimeout(() => r.remove(), 650);
            });
        })();

        /* ═══ Style ASP.NET-rendered inputs ══════════════ */
        // ASP.NET renders TextBox → <input>, DropDownList → <select>
        // Our CSS targets them by type, but let's also add focus glow to selects
        document.querySelectorAll('select').forEach(sel => {
            sel.addEventListener('focus', () =>
                sel.parentElement.querySelector('.icon').style.opacity = '1'
            );
            sel.addEventListener('blur', () =>
                sel.parentElement.querySelector('.icon').style.opacity = '.5'
            );
        });
    </script>
    
</body>
</html>
