<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Dolu Bolu Day 2</title>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.14.2/dist/gsap.min.js"></script>
    <style>
      @font-face { font-family: "Tight"; src: url("assets/fonts/InterTight-VF.ttf") format("truetype"); font-weight: 100 900; }
      @font-face { font-family: "Tight"; src: url("assets/fonts/InterTight-Italic-VF.ttf") format("truetype"); font-weight: 100 900; font-style: italic; }
      @font-face { font-family: "Hand"; src: url("assets/fonts/Caveat-VF.ttf") format("truetype"); font-weight: 400 700; }
      @font-face { font-family: "JBMono"; src: url("assets/fonts/JetBrainsMono-VF.ttf") format("truetype"); font-weight: 100 800; }
      :root {
        --yellow: #ffd60a; --glow: #ffe14d; --ink: #121110; --paper: #f1eee8; --grid: rgba(18,17,16,0.075);
        --red: #ff2d2d; --green: #2bff6a; --saffron: #ff9933;
        --shadow: 0 2px 4px rgba(18,17,16,0.08), 0 18px 40px rgba(18,17,16,0.16), 0 50px 100px rgba(18,17,16,0.18);
      }
      * { margin: 0; padding: 0; box-sizing: border-box; }
      html, body { width: 1080px; height: 1920px; overflow: hidden; background: var(--paper); }
      #root { position: relative; width: 100%; height: 100%; overflow: hidden; font-family: "Tight", sans-serif; color: var(--ink); letter-spacing: -0.035em; }
      .clip { position: absolute; inset: 0; }
      .abs { position: absolute; }
      .mono { font-family: "JBMono", monospace; letter-spacing: 0; }

      #paper { z-index: 0; background:
          linear-gradient(var(--grid) 2px, transparent 2px) 0 0 / 96px 96px,
          linear-gradient(90deg, var(--grid) 2px, transparent 2px) 0 0 / 96px 96px,
          var(--paper); }

      /* talking head: clip > layout > zoom > video. The matte stack mirrors it so the head can pop out of the card. */
      #vclip, #mclip { position: absolute; inset: 0; overflow: hidden; }
      #vclip { z-index: 2; }
      #mclip { z-index: 4; pointer-events: none; }
      #vframe, #mframe { position: absolute; inset: 0; transform-origin: 50% 0%; }
      #vzoom, #mzoom { position: absolute; inset: 0; transform-origin: 50% 38%; }
      #talk, #matte { position: absolute; inset: 0; width: 100%; height: 100%; object-fit: cover; filter: brightness(0.93) contrast(1.1) saturate(1.04); }
      #vgrade { position: absolute; inset: 0; background: radial-gradient(95% 70% at 50% 38%, transparent 50%, rgba(8,5,2,0.55) 100%), linear-gradient(180deg, rgba(8,5,2,0.15), transparent 25%, transparent 60%, rgba(8,5,2,0.55)); }
      #behind { position: absolute; left: 0; right: 0; top: 170px; text-align: center; opacity: 0; }
      #flash { position: absolute; inset: 0; z-index: 9; background: #fff; opacity: 0; pointer-events: none; }
      #redwash { position: absolute; inset: 0; z-index: 9; opacity: 0; pointer-events: none; background: radial-gradient(80% 60% at 50% 45%, transparent 40%, rgba(255,20,20,0.55)); }

      .panel { position: absolute; left: 0; right: 0; top: 0; height: 900px; z-index: 3; }
      .overlay { position: absolute; left: 0; right: 0; top: 0; height: 1920px; z-index: 5; }
      .card { position: absolute; border-radius: 34px; overflow: hidden; box-shadow: var(--shadow); background: #fff; }
      .dark { background: #15161b; }
      .mwrap { position: absolute; z-index: 3; border-radius: 34px; overflow: hidden; box-shadow: var(--shadow); opacity: 0; background: #000; }
      .mwrap video { position: absolute; inset: 0; width: 100%; height: 100%; object-fit: cover; }
      .pbar { position: absolute; left: 0; bottom: 0; height: 12px; width: 100%; background: var(--yellow); transform-origin: 0 50%; }
      .tag { display: inline-block; padding: 6px 22px 10px; font-weight: 800; font-size: 54px; letter-spacing: -0.03em; }
      .tag.g { background: #0d3b19; color: var(--green); box-shadow: 0 0 34px rgba(43,255,106,0.55); text-shadow: 0 0 18px rgba(43,255,106,0.8); }
      .tag.r { background: #1a0606; color: #ff4545; box-shadow: 0 0 30px rgba(255,45,45,0.5); text-shadow: 0 0 16px rgba(255,45,45,0.7); }
      .tag.k { background: var(--ink); color: #fff; }
      .ylist { position: absolute; background: var(--yellow); border-radius: 26px; padding: 28px 40px; font-weight: 600; font-size: 46px; line-height: 1.3; color: var(--ink); box-shadow: 0 20px 50px rgba(0,0,0,0.25); }
      .cloud { position: absolute; }
      .sticker { position: absolute; filter: drop-shadow(0 10px 18px rgba(0,0,0,0.3)); }

      /* ---------- captions: tight sans, lowercase, yellow bars, glow stacks, hand accents ---------- */
      #captions { z-index: 6; pointer-events: none; }
      .cap { position: absolute; left: 50px; right: 50px; display: flex; flex-wrap: wrap; justify-content: center; align-items: baseline; gap: 4px 16px; opacity: 0; text-align: center; }
      .cap.full, .cap.split { top: 1400px; font-size: 64px; }
      .cap[data-kind="stack"] { top: 1290px; }
      .cap .w { display: inline-block; font-weight: 600; transform-origin: 50% 80%; }
      .cap .w { font-size: 1em; color: #fff; paint-order: stroke fill; -webkit-text-stroke: 9px #0b0806; text-shadow: 0 6px 20px rgba(0,0,0,0.55); }
      .cap .w.bar { background: var(--yellow); color: var(--ink); font-weight: 800; padding: 0 14px 6px; font-size: 1.2em; text-shadow: none; -webkit-text-stroke: 0; box-shadow: 0 10px 24px rgba(0,0,0,0.35); }
      .cap .w.rbar { background: var(--red); color: #fff; font-weight: 800; padding: 0 14px 6px; font-size: 1.2em; text-shadow: none; -webkit-text-stroke: 0; box-shadow: 0 10px 24px rgba(0,0,0,0.35); }
      .cap .w.hand { font-family: "Hand"; font-weight: 700; font-size: 1.45em; letter-spacing: 0; }
      .cap .w.hand { color: var(--glow); text-shadow: 0 0 20px rgba(255,214,10,0.6); -webkit-text-stroke: 7px #0b0806; }
      .cap .w.it { font-style: italic; font-weight: 800; }
      .stack { display: flex; flex-direction: column; align-items: center; line-height: 0.92; }
      .cap .stack .st-t, .cap .stack .st-b { font-weight: 600; font-size: 56px; color: #fff; -webkit-text-stroke: 8px #0b0806; text-shadow: 0 2px 14px rgba(0,0,0,0.6); }
      .stack .st-b { align-self: flex-end; margin-right: 40px; margin-top: 4px; }
      .stack .st-t { align-self: flex-start; margin-left: 40px; margin-bottom: 4px; }
      .cap .stack .st-B { -webkit-text-stroke: 0; font-weight: 800; font-size: 150px; letter-spacing: -0.05em; color: var(--glow); text-shadow: 0 0 26px rgba(255,214,10,0.85), 0 0 70px rgba(255,180,0,0.55), 0 4px 10px rgba(0,0,0,0.4); }
      .cap .stack.red .st-B { color: #ff5a4a; text-shadow: 0 0 26px rgba(255,45,45,0.85), 0 0 70px rgba(255,20,20,0.5), 0 4px 10px rgba(0,0,0,0.4); }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="main" data-start="0" data-width="1080" data-height="1920" data-duration="{{T:81.55}}">
      <div id="paper" class="clip"></div>

      <div id="vclip">
        <div id="vframe"><div id="vzoom">
          <video id="talk" src="assets/media/talk-cut.mp4" muted playsinline data-start="0" data-duration="{{T:81.55}}" data-track-index="0"></video>
          <div id="vgrade"></div>
          <div id="behind">
            <div id="beh-pill" style="display:inline-flex; align-items:center; gap:14px; padding:14px 30px; border-radius:999px; background:rgba(18,17,16,0.85); color:#fff; font-weight:700; font-size:32px; letter-spacing:0.08em;"><span style="width:16px; height:16px; border-radius:50%; background:var(--yellow); display:block;"></span>VANGA AI KATHUKALAM</div>
            <div id="beh-day" style="font-weight:900; font-size:400px; line-height:0.9; letter-spacing:-0.06em; color:#fff; margin-top:12px; text-shadow:0 30px 80px rgba(0,0,0,0.35);">Day <span style="color:var(--yellow);">2</span></div>
          </div>
        </div></div>
      </div>
      <div id="mclip">
        <div id="mframe"><div id="mzoom">
          <video id="matte" src="assets/media/talk-matte.webm" muted playsinline data-start="0" data-duration="{{T:81.55}}" data-track-index="1"></video>
        </div></div>
      </div>

      <!-- ================= b-roll video cards (untimed wrappers, timed media) ================= -->
      <div class="mwrap" id="m-d1a" style="left:390px; top:80px; width:300px; height:533px;"><video id="v-d1a" src="assets/broll/day1-loss.mp4" muted playsinline data-start="{{T:6.3}}" data-duration="3.4" data-track-index="7"></video></div>
      <div class="mwrap" id="m-d1b" style="left:390px; top:80px; width:300px; height:533px;"><video id="v-d1b" src="assets/broll/day1-context.mp4" muted playsinline data-start="{{T:10.6}}" data-duration="3.6" data-track-index="7"></video></div>
      <div class="mwrap" id="m-rec1" style="left:60px; top:90px; width:960px; height:645px;"><video id="v-rec1" src="assets/broll/skills-screenrec.mp4" muted playsinline data-start="{{T:43.1}}" data-duration="{{D:43.1:47.0}}" data-track-index="7"></video><div class="pbar" id="pb-rec1"></div></div>
      <div class="mwrap" id="m-rec2" style="left:60px; top:60px; width:960px; height:540px;"><video id="v-rec2" src="assets/broll/skillmd-screenrec.mp4" muted playsinline data-start="{{T:47.0}}" data-duration="{{D:47.0:52.0}}" data-track-index="7"></video></div>

      <!-- ================= SPLIT PANELS ================= -->
      <section id="p1" class="panel clip" data-start="{{T:6.2}}" data-duration="{{D:6.2:14.9}}" data-track-index="2">
        <div class="abs tag k" id="p1-chip" style="left:400px; top:40px; font-size:30px; padding:6px 18px 8px; z-index:4; transform:rotate(-4deg);">previously · day 1</div>
        <img class="sticker" id="p1-twins" src="assets/twins.png" alt="" style="left:30px; top:300px; height:250px;" />
        <div class="abs" id="p1-tags" style="left:730px; top:180px; display:flex; flex-direction:column; gap:26px; align-items:flex-start;">
          <span class="tag g">context</span>
          <span class="tag g">detailed</span>
          <span class="tag g">prompts</span>
        </div>
      </section>

      <section id="p2" class="panel clip" data-start="{{T:14.9}}" data-duration="{{D:14.9:19.5}}" data-track-index="2">
        <div class="card dark" id="p2-app" style="left:60px; top:80px; width:960px; height:560px;">
          <div style="height:64px; display:flex; align-items:center; gap:12px; padding:0 26px; background:#1d1f27;"><i style="width:16px;height:16px;border-radius:50%;background:#ff5f57;display:block"></i><i style="width:16px;height:16px;border-radius:50%;background:#febc2e;display:block"></i><i style="width:16px;height:16px;border-radius:50%;background:#28c840;display:block"></i><span style="margin-left:18px; color:#8b90a5; font-size:24px; font-weight:600; letter-spacing:0;">chat · new prompt</span></div>
          <div id="p2-text" style="padding:34px 44px; color:#e8eaf3; font-size:40px; font-weight:500; line-height:1.45; letter-spacing:-0.02em;">
            <div class="p2-l">make a weekend poster for</div>
            <div class="p2-l"><b>Dolu Bolu Biryani Kadai</b>. budget ₹2,000.</div>
            <div class="p2-l">offer: 20% off on <span id="p2-slot" style="display:inline-block; min-width:200px; border-bottom:6px solid #ff4545; color:#ff4545; text-align:center;">_____</span> biryani</div>
          </div>
          <div class="abs tag r" id="p2-warn" style="left:44px; bottom:36px; font-size:34px;">missing: which biryani?</div>
          <div class="abs" id="p2-send" style="right:40px; bottom:36px; padding:12px 28px; border-radius:999px; background:#fff; color:#111; font-weight:800; font-size:32px;">send ↑</div>
        </div>
      </section>

      <section id="p3" class="panel clip" data-start="{{T:22.66}}" data-duration="{{D:22.66:26.72}}" data-track-index="2">
        <div class="card p3-m" style="left:60px; top:110px; width:470px; padding:26px 28px; background:#fff;">
          <div style="display:flex; align-items:center; gap:12px;"><div style="width:46px; height:46px; border-radius:50%; background:#ff9933;"></div><span style="font-weight:700; font-size:24px;">biryani_memes</span></div>
          <div style="font-weight:700; font-size:40px; line-height:1.15; margin-top:14px;">“veg chicken biryani” 🥦🍗 innovation level 💀</div>
          <div style="font-size:24px; color:#777; margin-top:10px;">♥ <span class="p3-like">0</span></div>
        </div>
        <div class="card p3-m" style="left:560px; top:80px; width:460px; padding:26px 28px; background:#15161b; color:#fff;">
          <div style="display:flex; align-items:center; gap:12px;"><div style="width:46px; height:46px; border-radius:50%; background:#2d7bff;"></div><span style="font-weight:700; font-size:24px;">tamil_trolls</span></div>
          <div style="font-weight:700; font-size:40px; line-height:1.15; margin-top:14px;">pure veg-ku chicken free 😂</div>
          <div style="font-size:24px; color:#9aa; margin-top:10px;">♥ <span class="p3-like">0</span></div>
        </div>
        <div class="card p3-m" style="left:240px; top:380px; width:600px; padding:26px 28px; background:var(--yellow);">
          <div style="display:flex; align-items:center; gap:12px;"><div style="width:46px; height:46px; border-radius:50%; background:#121110;"></div><span style="font-weight:700; font-size:24px;">foodie_chennai</span></div>
          <div style="font-weight:800; font-size:42px; line-height:1.15; margin-top:14px;">Dolu Bolu kadai: where AI cooks 🤖🍛</div>
          <div style="font-size:24px; color:#5a4a00; margin-top:10px;">♥ <span class="p3-like">0</span></div>
        </div>
        <div id="p3-emoji" class="abs" style="left:0; top:0; width:1080px; height:700px;"></div>
      </section>

      <section id="p4" class="panel clip" data-start="{{T:35.5}}" data-duration="{{D:35.5:43.1}}" data-track-index="2">
        <div class="card" id="p4-photo" style="left:60px; top:70px; width:960px; height:520px;"><img id="p4-img" src="assets/broll/biryani.jpg" alt="" style="position:absolute; inset:0; width:100%; height:100%; object-fit:cover;" /><div class="abs" style="left:24px; top:22px; padding:8px 18px 10px; background:rgba(0,0,0,0.6); color:#fff; font-weight:700; font-size:28px; border-radius:12px;">recipe = same taste, every day</div></div>
        <div class="ylist" id="p4-list" style="left:120px; top:250px; width:620px;">
          <div class="p4-li">1. same masala</div><div class="p4-li">2. same ratio</div><div class="p4-li">3. same dum time</div>
          <img class="sticker" src="assets/twins.png" alt="" style="right:-60px; top:-90px; height:150px;" />
        </div>
        <div class="abs" id="p4-week" style="left:60px; right:60px; top:540px; display:flex; gap:10px;"></div>
      </section>

      <section id="p5" class="panel clip" data-start="{{T:52.0}}" data-duration="{{D:52.0:58.8}}" data-track-index="2">
        <svg class="abs" id="p5-chart" viewBox="0 0 960 560" style="left:60px; top:70px; width:960px; height:560px; overflow:visible;">
          <defs><linearGradient id="p5g" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="#2bff6a" stop-opacity="0.45"/><stop offset="1" stop-color="#2bff6a" stop-opacity="0"/></linearGradient></defs>
          <path id="p5-area" d="M20 500 L250 330 L480 330 L710 330 L940 330 L940 560 L20 560 Z" fill="url(#p5g)"/>
          <path id="p5-line" d="M20 500 L250 330 L480 330 L710 330 L940 330" fill="none" stroke="#18d65a" stroke-width="12" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        <div class="abs" id="p5-outs" style="left:60px; right:60px; top:150px; display:flex; justify-content:space-around;"></div>
        <div class="abs tag k" id="p5-lbl" style="left:80px; top:80px; font-size:36px;">SKILL.md → same result</div>
      </section>

      <section id="p6" class="panel clip" data-start="{{T:58.8}}" data-duration="{{D:58.8:68.0}}" data-track-index="2">
        <div class="card dark" id="p6-chat" style="left:60px; top:70px; width:960px; height:200px; padding:28px 34px; display:flex; flex-direction:column; gap:16px;">
          <div style="align-self:flex-end; padding:14px 26px; border-radius:22px; background:#2f3140; color:#fff; font-weight:600; font-size:36px;">sunday special poster</div>
          <div id="p6-using" style="align-self:flex-start; padding:8px 18px; border-radius:12px; background:#0d3b19; color:#2bff6a; font-weight:700; font-size:28px; letter-spacing:0;" class="mono">⚡ skill: sunday-poster</div>
        </div>
        <div class="card" id="p6-poster" style="left:250px; top:300px; width:580px; height:340px; background:linear-gradient(160deg,#fffaf0,#ffe2b0); display:flex; flex-direction:column; align-items:center; justify-content:center;">
          <div style="font-weight:700; font-size:24px; letter-spacing:0.18em; color:#a8560c;">SUNDAY SPECIAL</div>
          <div style="font-weight:900; font-size:96px; line-height:0.95; letter-spacing:-0.05em; color:#3b1f0e;">mutton</div>
          <div style="font-weight:900; font-size:96px; line-height:0.95; letter-spacing:-0.05em; color:#ff9933;">biryani</div>
          <div class="tag" style="margin-top:12px; background:#121110; color:var(--yellow); font-size:30px;">buy 1 get 1 · first 50</div>
          <div class="abs" id="p6-sweep" style="top:-20%; bottom:-20%; left:-200px; width:160px; background:linear-gradient(90deg,transparent,rgba(255,255,255,0.8),transparent); transform:skewX(-18deg);"></div>
        </div>
        <div class="abs tag g" id="p6-ok" style="left:780px; top:290px; font-size:36px;">clear ✓</div>
      </section>

      <section id="p7" class="panel clip" data-start="{{T:70.0}}" data-duration="{{D:70.0:74.6}}" data-track-index="2">
        <div class="card dark" style="left:60px; top:70px; width:960px; height:560px; padding:36px 40px; color:#fff;">
          <div style="display:flex; justify-content:space-between; align-items:center;"><span style="font-weight:700; font-size:30px; color:#9aa;">every weekend, by hand</span><span class="tag r" style="font-size:28px;">manual</span></div>
          <div id="p7-grid" style="display:grid; grid-template-columns:repeat(13, 1fr); gap:10px; margin-top:24px;"></div>
          <div style="display:flex; align-items:center; gap:30px; margin-top:30px;">
            <div style="position:relative; width:150px; height:150px; border-radius:50%; border:6px solid #fff; flex:none;">
              <div id="p7-hand" class="abs" style="left:69px; top:20px; width:6px; height:56px; background:#ff4545; border-radius:3px; transform-origin:50% 100%;"></div>
            </div>
            <div><div style="font-weight:900; font-size:110px; line-height:1; letter-spacing:-0.05em;"><span id="p7-num">0</span></div><div style="font-weight:600; font-size:30px; color:#9aa;">weekends a year 😩</div></div>
          </div>
        </div>
      </section>

      <!-- ================= FULL-FRAME OVERLAYS ================= -->
      <div class="overlay clip" id="o1" data-start="{{T:19.5}}" data-duration="{{D:19.5:22.66}}" data-track-index="3">
        <div class="card" id="o1-pip" style="left:60px; top:90px; width:960px; height:560px;"><img id="o1-img" src="assets/broll/biryani.jpg" alt="" style="position:absolute; inset:0; width:100%; height:100%; object-fit:cover;" /><div class="pbar" id="pb-o1"></div></div>
        <div class="abs tag g" id="o1-veg" style="left:110px; top:470px; transform:rotate(-6deg);">veg 🥦</div>
        <div class="abs tag r" id="o1-chk" style="left:640px; top:440px; transform:rotate(5deg);">chicken 🍗</div>
        <div class="abs" id="o1-q" style="left:480px; top:300px; font-family:Hand; font-weight:700; font-size:170px; color:var(--yellow); text-shadow:0 0 30px rgba(255,214,10,0.8);">?!</div>
      </div>
      <div class="overlay clip" id="o2" data-start="{{T:26.72}}" data-duration="{{D:26.72:33.5}}" data-track-index="3">
        <div class="cloud" id="o2-cloud" style="left:210px; top:60px; width:660px; height:440px;">
          <svg viewBox="0 0 660 440" style="position:absolute; inset:0; width:100%; height:100%; overflow:visible; filter:drop-shadow(0 18px 30px rgba(0,0,0,0.35));"><path d="M120 340 C40 340 20 260 80 230 C40 170 100 100 170 120 C190 50 290 30 340 80 C390 20 500 40 510 110 C600 100 640 190 590 240 C650 290 600 360 520 345 C490 400 400 410 360 370 C320 410 220 405 200 360 C170 370 140 360 120 340 Z" fill="#fff"/></svg>
          <div class="abs" style="left:120px; top:120px; width:420px;">
            <div style="font-weight:700; font-size:30px; color:#777;">prompt detail</div>
            <div style="height:20px; border-radius:10px; background:#eee; margin-top:8px; overflow:hidden;"><div id="o2-bar" style="height:100%; width:100%; background:#18d65a; transform-origin:0 50%;"></div></div>
            <div style="display:flex; justify-content:space-between; margin-top:20px;"><span style="font-weight:700; font-size:30px; color:#777;">result</span><span class="tag r" id="o2-x" style="font-size:34px;">✗ not this</span></div>
          </div>
        </div>
        <i class="abs o2-dot" style="left:470px; top:520px; width:46px; height:46px; border-radius:50%; background:#fff; display:block; box-shadow:0 8px 16px rgba(0,0,0,0.3);"></i>
        <i class="abs o2-dot" style="left:500px; top:590px; width:28px; height:28px; border-radius:50%; background:#fff; display:block; box-shadow:0 8px 16px rgba(0,0,0,0.3);"></i>
      </div>
      <div class="overlay clip" id="o3" data-start="{{T:43.1}}" data-duration="{{D:43.1:47.0}}" data-track-index="3">
        <div class="abs tag k" id="o3-chip" style="left:80px; top:60px; font-size:30px; z-index:5;">claude · agent skills</div>
      </div>
      <div class="overlay clip" id="o4" data-start="{{T:74.6}}" data-duration="{{D:74.6:78.3}}" data-track-index="3">
        <div class="cloud" id="o4-cloud" style="left:210px; top:60px; width:660px; height:440px;">
          <svg viewBox="0 0 660 440" style="position:absolute; inset:0; width:100%; height:100%; overflow:visible; filter:drop-shadow(0 18px 30px rgba(0,0,0,0.35));"><path d="M120 340 C40 340 20 260 80 230 C40 170 100 100 170 120 C190 50 290 30 340 80 C390 20 500 40 510 110 C600 100 640 190 590 240 C650 290 600 360 520 345 C490 400 400 410 360 370 C320 410 220 405 200 360 C170 370 140 360 120 340 Z" fill="#fff"/></svg>
          <div class="abs" style="left:0; right:0; top:120px; text-align:center;">
            <div style="font-size:90px;">🤖⚙️</div>
            <div id="o4-next" style="font-weight:900; font-size:64px; letter-spacing:-0.04em; filter:blur(10px);">automation?</div>
          </div>
        </div>
        <i class="abs o4-dot" style="left:470px; top:520px; width:46px; height:46px; border-radius:50%; background:#fff; display:block;"></i>
        <i class="abs o4-dot" style="left:500px; top:590px; width:28px; height:28px; border-radius:50%; background:#fff; display:block;"></i>
        <div class="abs tag k" id="o4-day" style="left:760px; top:470px; font-size:32px; transform:rotate(6deg);">day 3 🔒</div>
      </div>
      <div class="overlay clip" id="o5" data-start="{{T:78.3}}" data-duration="{{D:78.3:79.9}}" data-track-index="3">
        <div class="abs" id="o5-name" style="left:70px; top:120px; padding:20px 30px 24px; background:rgba(18,17,16,0.82); border-radius:24px; color:#fff;">
          <div style="font-weight:800; font-size:54px; letter-spacing:-0.04em;">Joshua <span style="background:var(--yellow); color:var(--ink); padding:0 10px 4px;">Collins</span></div>
          <div style="font-weight:600; font-size:28px; color:#bbb; margin-top:6px;">vanga AI kathukalam · day 2 of 5</div>
        </div>
      </div>
      <div class="overlay clip" id="o6" data-start="{{T:79.9}}" data-duration="{{D:79.9:81.55}}" data-track-index="3">
        <div class="abs" id="o6-btns" style="left:0; right:0; top:130px; display:flex; justify-content:center; gap:18px;">
          <div id="o6-f" style="padding:20px 44px 24px; background:var(--yellow); color:var(--ink); font-weight:800; font-size:44px; border-radius:999px; box-shadow:0 16px 40px rgba(0,0,0,0.35);">+ follow</div>
          <div id="o6-s" style="padding:20px 44px 24px; background:#fff; color:var(--ink); font-weight:800; font-size:44px; border-radius:999px; box-shadow:0 16px 40px rgba(0,0,0,0.35);">save 🔖</div>
        </div>
      </div>

      <div id="captions" class="clip" data-start="0" data-duration="{{T:81.55}}" data-track-index="5"></div>
      <div id="flash"></div>
      <div id="redwash"></div>

      <audio id="vo" src="assets/media/vo-cut.m4a" data-start="0" data-duration="{{T:81.55}}" data-track-index="10" data-volume="1"></audio>
      <audio id="music" src="assets/media/music.m4a" data-start="0" data-duration="{{T:81.55}}" data-track-index="11" data-volume="1"></audio>
      <audio id="sfxh0" src="assets/sfx/hook-riser.mp3" data-start="0.0" data-duration="2.9" data-track-index="19" data-volume="0.22"></audio>
      <audio id="sfxh1" src="assets/sfx/zoom-out.mp3" data-start="1.5" data-duration="0.6" data-track-index="18" data-volume="0.19"></audio>
      <audio id="sfx0" src="assets/sfx/impact-bass-1.mp3" data-start="{{T:0.9}}" data-duration="0.9" data-track-index="20" data-volume="0.171"></audio>
      <audio id="sfx1" src="assets/sfx/zoom-in.mp3" data-start="{{T:2.55}}" data-duration="0.9" data-track-index="21" data-volume="0.19"></audio>
      <audio id="sfx2" src="assets/sfx/tick.mp3" data-start="{{T:2.9}}" data-duration="0.9" data-track-index="22" data-volume="0.19"></audio>
      <audio id="sfx3" src="assets/sfx/zoom-out.mp3" data-start="{{T:3.3}}" data-duration="0.9" data-track-index="23" data-volume="0.152"></audio>
      <audio id="sfx4" src="assets/sfx/swipe.mp3" data-start="{{T:3.9}}" data-duration="0.9" data-track-index="24" data-volume="0.152"></audio>
      <audio id="sfx5" src="assets/sfx/boom.mp3" data-start="{{T:4.9}}" data-duration="1.0" data-track-index="20" data-volume="0.22"></audio>
      <audio id="sfx6" src="assets/sfx/whoosh-short.mp3" data-start="{{T:6.15}}" data-duration="0.9" data-track-index="21" data-volume="0.084"></audio>
      <audio id="sfx7" src="assets/sfx/swipe.mp3" data-start="{{T:6.3}}" data-duration="0.9" data-track-index="22" data-volume="0.144"></audio>
      <audio id="sfx8" src="assets/sfx/shutter.mp3" data-start="{{T:6.4}}" data-duration="0.9" data-track-index="23" data-volume="0.133"></audio>
      <audio id="sfx9" src="assets/sfx/tick.mp3" data-start="{{T:7.0}}" data-duration="0.9" data-track-index="24" data-volume="0.19"></audio>
      <audio id="sfx10" src="assets/sfx/pop.mp3" data-start="{{T:8.3}}" data-duration="0.9" data-track-index="20" data-volume="0.152"></audio>
      <audio id="sfx11" src="assets/sfx/swipe.mp3" data-start="{{T:10.6}}" data-duration="0.9" data-track-index="21" data-volume="0.144"></audio>
      <audio id="sfx12" src="assets/sfx/ding.mp3" data-start="{{T:10.8}}" data-duration="0.9" data-track-index="22" data-volume="0.095"></audio>
      <audio id="sfx13" src="assets/sfx/tick.mp3" data-start="{{T:11.0}}" data-duration="0.9" data-track-index="23" data-volume="0.19"></audio>
      <audio id="sfx14" src="assets/sfx/ding.mp3" data-start="{{T:11.25}}" data-duration="0.9" data-track-index="24" data-volume="0.095"></audio>
      <audio id="sfx15" src="assets/sfx/ding.mp3" data-start="{{T:11.7}}" data-duration="0.9" data-track-index="20" data-volume="0.095"></audio>
      <audio id="sfx16" src="assets/sfx/tick.mp3" data-start="{{T:12.3}}" data-duration="0.9" data-track-index="21" data-volume="0.19"></audio>
      <audio id="sfx17" src="assets/sfx/swipe.mp3" data-start="{{T:14.9}}" data-duration="0.9" data-track-index="22" data-volume="0.144"></audio>
      <audio id="sfx18" src="assets/sfx/tick.mp3" data-start="{{T:15.2}}" data-duration="0.9" data-track-index="23" data-volume="0.19"></audio>
      <audio id="sfx19" src="assets/sfx/typing.mp3" data-start="{{T:15.2}}" data-duration="2.0" data-track-index="24" data-volume="0.084"></audio>
      <audio id="sfx20" src="assets/sfx/error.mp3" data-start="{{T:17.6}}" data-duration="0.9" data-track-index="20" data-volume="0.114"></audio>
      <audio id="sfx21" src="assets/sfx/click.mp3" data-start="{{T:18.6}}" data-duration="0.9" data-track-index="21" data-volume="0.152"></audio>
      <audio id="sfx22" src="assets/sfx/whoosh.mp3" data-start="{{T:18.85}}" data-duration="0.9" data-track-index="22" data-volume="0.133"></audio>
      <audio id="sfx23" src="assets/sfx/whoosh-short.mp3" data-start="{{T:19.45}}" data-duration="0.9" data-track-index="23" data-volume="0.084"></audio>
      <audio id="sfx24" src="assets/sfx/swipe.mp3" data-start="{{T:19.55}}" data-duration="0.9" data-track-index="24" data-volume="0.144"></audio>
      <audio id="sfx25" src="assets/sfx/zoom-in.mp3" data-start="{{T:19.6}}" data-duration="0.9" data-track-index="20" data-volume="0.19"></audio>
      <audio id="sfx26" src="assets/sfx/impact-bass-2.mp3" data-start="{{T:20.3}}" data-duration="0.9" data-track-index="21" data-volume="0.152"></audio>
      <audio id="sfx27" src="assets/sfx/pop.mp3" data-start="{{T:20.5}}" data-duration="0.9" data-track-index="22" data-volume="0.152"></audio>
      <audio id="sfx28" src="assets/sfx/zoom-out.mp3" data-start="{{T:20.7}}" data-duration="0.9" data-track-index="23" data-volume="0.152"></audio>
      <audio id="sfx29" src="assets/sfx/pop.mp3" data-start="{{T:20.95}}" data-duration="0.9" data-track-index="24" data-volume="0.152"></audio>
      <audio id="sfx30" src="assets/sfx/zoom-in.mp3" data-start="{{T:21.2}}" data-duration="0.9" data-track-index="20" data-volume="0.19"></audio>
      <audio id="sfx31" src="assets/sfx/sparkle.mp3" data-start="{{T:21.5}}" data-duration="0.9" data-track-index="21" data-volume="0.133"></audio>
      <audio id="sfx32" src="assets/sfx/zoom-out.mp3" data-start="{{T:21.8}}" data-duration="0.9" data-track-index="22" data-volume="0.152"></audio>
      <audio id="sfx33" src="assets/sfx/whoosh-short.mp3" data-start="{{T:22.61}}" data-duration="0.9" data-track-index="23" data-volume="0.084"></audio>
      <audio id="sfx34" src="assets/sfx/swipe.mp3" data-start="{{T:22.7}}" data-duration="0.9" data-track-index="24" data-volume="0.144"></audio>
      <audio id="sfx35" src="assets/sfx/swipe.mp3" data-start="{{T:23.02}}" data-duration="0.9" data-track-index="20" data-volume="0.144"></audio>
      <audio id="sfx36" src="assets/sfx/swipe.mp3" data-start="{{T:23.34}}" data-duration="0.9" data-track-index="21" data-volume="0.144"></audio>
      <audio id="sfx37" src="assets/sfx/tick.mp3" data-start="{{T:24.0}}" data-duration="0.9" data-track-index="22" data-volume="0.19"></audio>
      <audio id="sfx38" src="assets/sfx/sparkle.mp3" data-start="{{T:24.2}}" data-duration="0.9" data-track-index="23" data-volume="0.095"></audio>
      <audio id="sfx39" src="assets/sfx/whoosh-short.mp3" data-start="{{T:26.669999999999998}}" data-duration="0.9" data-track-index="24" data-volume="0.084"></audio>
      <audio id="sfx40" src="assets/sfx/pop.mp3" data-start="{{T:27.0}}" data-duration="0.9" data-track-index="20" data-volume="0.171"></audio>
      <audio id="sfx41" src="assets/sfx/error.mp3" data-start="{{T:31.0}}" data-duration="0.9" data-track-index="21" data-volume="0.114"></audio>
      <audio id="sfx42" src="assets/sfx/riser.mp3" data-start="{{T:32.7}}" data-duration="1.7" data-track-index="22" data-volume="0.106"></audio>
      <audio id="sfx43" src="assets/sfx/zoom-in.mp3" data-start="{{T:34.4}}" data-duration="0.9" data-track-index="23" data-volume="0.19"></audio>
      <audio id="sfx44" src="assets/sfx/boom.mp3" data-start="{{T:34.42}}" data-duration="1.0" data-track-index="24" data-volume="0.22"></audio>
      <audio id="sfx45" src="assets/sfx/zoom-out.mp3" data-start="{{T:35.25}}" data-duration="0.9" data-track-index="20" data-volume="0.152"></audio>
      <audio id="sfx46" src="assets/sfx/whoosh-short.mp3" data-start="{{T:35.45}}" data-duration="0.9" data-track-index="21" data-volume="0.084"></audio>
      <audio id="sfx47" src="assets/sfx/swipe.mp3" data-start="{{T:35.5}}" data-duration="0.9" data-track-index="22" data-volume="0.144"></audio>
      <audio id="sfx48" src="assets/sfx/tick.mp3" data-start="{{T:36.6}}" data-duration="0.9" data-track-index="23" data-volume="0.19"></audio>
      <audio id="sfx49" src="assets/sfx/swipe.mp3" data-start="{{T:37.3}}" data-duration="0.9" data-track-index="24" data-volume="0.144"></audio>
      <audio id="sfx50" src="assets/sfx/tick.mp3" data-start="{{T:37.5}}" data-duration="0.9" data-track-index="20" data-volume="0.152"></audio>
      <audio id="sfx51" src="assets/sfx/tick.mp3" data-start="{{T:37.85}}" data-duration="0.9" data-track-index="21" data-volume="0.152"></audio>
      <audio id="sfx52" src="assets/sfx/tick.mp3" data-start="{{T:38.2}}" data-duration="0.9" data-track-index="22" data-volume="0.152"></audio>
      <audio id="sfx53" src="assets/sfx/pop.mp3" data-start="{{T:40.45}}" data-duration="0.9" data-track-index="23" data-volume="0.114"></audio>
      <audio id="sfx54" src="assets/sfx/pop.mp3" data-start="{{T:40.8}}" data-duration="0.9" data-track-index="24" data-volume="0.114"></audio>
      <audio id="sfx55" src="assets/sfx/pop.mp3" data-start="{{T:41.15}}" data-duration="0.9" data-track-index="20" data-volume="0.114"></audio>
      <audio id="sfx56" src="assets/sfx/tick.mp3" data-start="{{T:41.3}}" data-duration="0.9" data-track-index="21" data-volume="0.19"></audio>
      <audio id="sfx57" src="assets/sfx/whoosh-short.mp3" data-start="{{T:43.050000000000004}}" data-duration="0.9" data-track-index="22" data-volume="0.084"></audio>
      <audio id="sfx58" src="assets/sfx/swipe.mp3" data-start="{{T:43.15}}" data-duration="0.9" data-track-index="23" data-volume="0.144"></audio>
      <audio id="sfx59" src="assets/sfx/typing.mp3" data-start="{{T:43.5}}" data-duration="2.0" data-track-index="24" data-volume="0.057"></audio>
      <audio id="sfx60" src="assets/sfx/whoosh-short.mp3" data-start="{{T:46.95}}" data-duration="0.9" data-track-index="20" data-volume="0.084"></audio>
      <audio id="sfx61" src="assets/sfx/swipe.mp3" data-start="{{T:47.05}}" data-duration="0.9" data-track-index="21" data-volume="0.144"></audio>
      <audio id="sfx62" src="assets/sfx/tick.mp3" data-start="{{T:48.0}}" data-duration="0.9" data-track-index="22" data-volume="0.19"></audio>
      <audio id="sfx63" src="assets/sfx/tick.mp3" data-start="{{T:49.8}}" data-duration="0.9" data-track-index="23" data-volume="0.19"></audio>
      <audio id="sfx64" src="assets/sfx/swipe.mp3" data-start="{{T:52.15}}" data-duration="0.9" data-track-index="24" data-volume="0.144"></audio>
      <audio id="sfx65" src="assets/sfx/pop.mp3" data-start="{{T:53.2}}" data-duration="0.9" data-track-index="20" data-volume="0.133"></audio>
      <audio id="sfx66" src="assets/sfx/pop.mp3" data-start="{{T:53.65}}" data-duration="0.9" data-track-index="21" data-volume="0.133"></audio>
      <audio id="sfx67" src="assets/sfx/pop.mp3" data-start="{{T:54.1}}" data-duration="0.9" data-track-index="22" data-volume="0.133"></audio>
      <audio id="sfx68" src="assets/sfx/pop.mp3" data-start="{{T:54.55}}" data-duration="0.9" data-track-index="23" data-volume="0.133"></audio>
      <audio id="sfx69" src="assets/sfx/ding.mp3" data-start="{{T:55.0}}" data-duration="0.9" data-track-index="24" data-volume="0.114"></audio>
      <audio id="sfx70" src="assets/sfx/swipe.mp3" data-start="{{T:58.8}}" data-duration="0.9" data-track-index="20" data-volume="0.144"></audio>
      <audio id="sfx71" src="assets/sfx/tick.mp3" data-start="{{T:60.1}}" data-duration="0.9" data-track-index="21" data-volume="0.19"></audio>
      <audio id="sfx72" src="assets/sfx/click.mp3" data-start="{{T:62.4}}" data-duration="0.9" data-track-index="22" data-volume="0.152"></audio>
      <audio id="sfx73" src="assets/sfx/sparkle.mp3" data-start="{{T:64.6}}" data-duration="0.9" data-track-index="23" data-volume="0.152"></audio>
      <audio id="sfx74" src="assets/sfx/ding.mp3" data-start="{{T:66.0}}" data-duration="0.9" data-track-index="24" data-volume="0.133"></audio>
      <audio id="sfx75" src="assets/sfx/tick.mp3" data-start="{{T:66.8}}" data-duration="0.9" data-track-index="20" data-volume="0.19"></audio>
      <audio id="sfx76" src="assets/sfx/whoosh-short.mp3" data-start="{{T:67.95}}" data-duration="0.9" data-track-index="21" data-volume="0.084"></audio>
      <audio id="sfx77" src="assets/sfx/boom.mp3" data-start="{{T:68.05}}" data-duration="1.0" data-track-index="22" data-volume="0.22"></audio>
      <audio id="sfx78" src="assets/sfx/glitch-2.mp3" data-start="{{T:68.05}}" data-duration="0.9" data-track-index="23" data-volume="0.171"></audio>
      <audio id="sfx79" src="assets/sfx/zoom-in.mp3" data-start="{{T:68.05}}" data-duration="0.9" data-track-index="24" data-volume="0.19"></audio>
      <audio id="sfx80" src="assets/sfx/zoom-out.mp3" data-start="{{T:68.6}}" data-duration="0.9" data-track-index="20" data-volume="0.152"></audio>
      <audio id="sfx81" src="assets/sfx/whoosh-short.mp3" data-start="{{T:69.95}}" data-duration="0.9" data-track-index="21" data-volume="0.084"></audio>
      <audio id="sfx82" src="assets/sfx/swipe.mp3" data-start="{{T:70.2}}" data-duration="0.9" data-track-index="22" data-volume="0.144"></audio>
      <audio id="sfx83" src="assets/sfx/tick.mp3" data-start="{{T:70.9}}" data-duration="0.9" data-track-index="23" data-volume="0.19"></audio>
      <audio id="sfx84" src="assets/sfx/tick.mp3" data-start="{{T:72.0}}" data-duration="0.9" data-track-index="24" data-volume="0.19"></audio>
      <audio id="sfx85" src="assets/sfx/whoosh-short.mp3" data-start="{{T:74.55}}" data-duration="0.9" data-track-index="20" data-volume="0.084"></audio>
      <audio id="sfx86" src="assets/sfx/riser.mp3" data-start="{{T:74.7}}" data-duration="1.7" data-track-index="21" data-volume="0.084"></audio>
      <audio id="sfx87" src="assets/sfx/pop.mp3" data-start="{{T:74.9}}" data-duration="0.9" data-track-index="22" data-volume="0.171"></audio>
      <audio id="sfx88" src="assets/sfx/shutter.mp3" data-start="{{T:76.2}}" data-duration="0.9" data-track-index="23" data-volume="0.133"></audio>
      <audio id="sfx89" src="assets/sfx/impact-bass-1.mp3" data-start="{{T:76.4}}" data-duration="0.9" data-track-index="24" data-volume="0.152"></audio>
      <audio id="sfx90" src="assets/sfx/swipe.mp3" data-start="{{T:78.35}}" data-duration="0.9" data-track-index="20" data-volume="0.144"></audio>
      <audio id="sfx91" src="assets/sfx/tick.mp3" data-start="{{T:78.9}}" data-duration="0.9" data-track-index="21" data-volume="0.19"></audio>
      <audio id="sfx92" src="assets/sfx/swipe.mp3" data-start="{{T:79.95}}" data-duration="0.9" data-track-index="22" data-volume="0.144"></audio>
      <audio id="sfx93" src="assets/sfx/ding.mp3" data-start="{{T:80.4}}" data-duration="0.9" data-track-index="23" data-volume="0.114"></audio>
      <audio id="sfx94" src="assets/sfx/boom.mp3" data-start="{{T:80.5}}" data-duration="1.0" data-track-index="24" data-volume="0.209"></audio>
      <audio id="sfx95" src="assets/sfx/zoom-in.mp3" data-start="{{T:80.5}}" data-duration="0.9" data-track-index="20" data-volume="0.19"></audio>
      <audio id="sfx96" src="assets/sfx/zoom-out.mp3" data-start="{{T:81.1}}" data-duration="0.9" data-track-index="21" data-volume="0.152"></audio>
    </div>

    <script>
      (function () {
        const KEEP = /*KEEP*/;
        const SPEED = 1.05;
        // original recording second -> edited timeline second
        const T = (t) => {
          let acc = 0;
          for (const [s, e] of KEEP) {
            if (t < s) return acc / SPEED;
            if (t <= e) return (acc + t - s) / SPEED;
            acc += e - s;
          }
          return acc / SPEED;
        };
        const $ = (s) => document.querySelector(s);
        const $$ = (s) => document.querySelectorAll(s);
        const rng = (seed) => { let s = seed >>> 0; return () => { s = (s * 1664525 + 1013904223) >>> 0; return s / 4294967296; }; };

        // ---------- generated bits ----------
        $("#p4-week").innerHTML = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"].map((d) => `<div class="p4-day" style="flex:1; padding:12px 0 14px; background:#fff; border-radius:16px; box-shadow:0 8px 20px rgba(0,0,0,0.12); text-align:center; font-weight:700; font-size:24px;">${d}<div style="font-size:34px;">🍛</div><div style="color:#18a64a; font-size:22px;">same ✓</div></div>`).join("");
        $("#p5-outs").innerHTML = [0, 1, 2, 3].map((i) => `<div class="p5-out" style="width:180px; height:120px; border-radius:18px; background:linear-gradient(160deg,#fffaf0,#ffe2b0); box-shadow:0 12px 28px rgba(0,0,0,0.18); display:flex; flex-direction:column; align-items:center; justify-content:center; margin-top:${i ? 120 : 280}px; border:3px solid #18d65a;"><span style="font-weight:900; font-size:30px; line-height:1; color:#3b1f0e;">mutton</span><span style="font-weight:900; font-size:30px; line-height:1; color:#ff9933;">biryani</span><span style="color:#18a64a; font-weight:800; font-size:26px;">✓</span></div>`).join("");
        let g = "";
        for (let i = 0; i < 52; i++) g += `<i class="p7-w" style="display:block; height:44px; border-radius:10px; background:#2a2c35;"></i>`;
        $("#p7-grid").innerHTML = g;
        const er = rng(4), EM = ["😂", "🤣", "💀", "😭", "🔥"];
        let em = "";
        for (let i = 0; i < 16; i++) em += `<span class="p3-e" style="position:absolute; left:${(60 + er() * 940).toFixed(0)}px; top:${(520 + er() * 160).toFixed(0)}px; font-size:${(56 + er() * 36).toFixed(0)}px;">${EM[i % 5]}</span>`;
        $("#p3-emoji").innerHTML = em;

        // ---------- layout plan (original seconds) ----------
        const LAYOUT = [[0, "F"], [6.2, "S"], [19.5, "F"], [22.66, "S"], [26.72, "F"], [35.5, "S"], [43.1, "F"], [47.0, "S"], [68.0, "F"], [70.0, "S"], [74.6, "F"]];
        const layoutAt = (t) => { let l = "F"; LAYOUT.forEach(([s, v]) => { if (t >= s - 0.001) l = v; }); return l; };

        // ---------- captions ----------
        // chunks split by "|" share the phrase time by length. Markup:
        //   [x y] yellow bar   !x! red bar   ~x~ handwritten accent   _x_ bold italic
        //   {small|BIG|small} glow stack (whole chunk); a 4th field "red" tints the stack red.
        const PHRASES = [
          [0.05, 2.46, "AI use pannumbodhu|{adikkadi|mistakes|pannureengala?}"],
          [2.46, 3.86, "indha video|[ungalukku dhaan]"],
          [3.86, 5.2, "vaanga AI kathukalam|series-la inniki"],
          [6.2, 10.68, "last episode [loss]-kku appuram|namma Dolu Bolu|nalla oru ~lesson~ kathukittaanga"],
          [10.68, 14.9, "ippo nalla [context]-oda|[detailed prompts] mattum dhaan|use panraanga"],
          [14.9, 19.45, "oru naal [avasara avasarama]|prompt kudukkumbodhu|enna biryani-nu|mention panna !marandhaanga!"],
          [19.52, 22.6, "kadaisila ChatGPT|{|veg chicken biryani|kuduthiruchu 😭}"],
          [22.66, 26.7, "adhukku appuram enna...|ella [memes]-layum|namma Dolu Bolu kadai dhaan 😂"],
          [26.72, 33.45, "sometimes evvalavu detail-aa|prompt kuduthaalum|oru ~chinna vishayam~ miss aana|expect panna result|_kidaikkaadhu_"],
          [33.5, 35.45, "{adhukku solution dhaan|skills|}"],
          [35.5, 40.4, "oru cook kitta|[recipe card] irukkum|enna samaikkanum|_eppadi_ samaikkanum"],
          [40.4, 43.05, "adha paathu|[daily] replicate pannuvaanga"],
          [43.1, 47.0, "adhe concept dhaan|skills = ~recipe card~"],
          [47.0, 52.0, "namma kudukkura [steps]|namma kudukkura [instructions]|_exact_-ah follow panni"],
          [52.0, 57.6, "expect panra result|{|thirumba thirumba|kidaikkum ✅}"],
          [58.8, 62.44, "ippo Dolu Bolu|[sunday special poster]-nu|sonna podhum"],
          [62.44, 67.9, "skill-la irukkura instructions vechu|ChatGPT ~clear~-aana poster|[ready] panni kudukkum"],
          [68.0, 70.0, "{but still...|problem|irukku}", "red"],
          [70.04, 74.55, "every [saturday evening]|or [sunday morning]|Dolu Bolu dhaan|poi ChatGPT-kitta kekkanum 😩"],
          [74.62, 78.25, "indha problem-a|eppadi _overcome_ panradhu?|{next episode-la|paakalaam|}"],
          [78.3, 79.84, "until then|it's [Joshua Collins]"],
          [79.84, 81.45, "{let's build the|leverage|together 🚀}"],
        ];
        const CAPS = [];
        PHRASES.forEach(([a, b, txt, tint]) => {
          const parts = txt.split("|").reduce((acc, p) => {
            // keep {…|…|…} stacks as one chunk
            if (acc.length && (acc[acc.length - 1].match(/\{/g) || []).length > (acc[acc.length - 1].match(/\}/g) || []).length) acc[acc.length - 1] += "|" + p;
            else acc.push(p);
            return acc;
          }, []);
          const w = parts.map((p) => p.replace(/[{}\[\]~_!|]/g, "").length + 8), tot = w.reduce((x, y) => x + y, 0);
          let t = a;
          parts.forEach((p, i) => { const d = ((b - a) * w[i]) / tot; CAPS.push([t, t + d, p, tint || ""]); t += d; });
        });
        const esc = (s) => s.replace(/&/g, "&amp;").replace(/</g, "&lt;");
        const capRoot = $("#captions");
        CAPS.forEach((c, i) => {
          const d = document.createElement("div");
          const split = layoutAt(c[0] + 0.05) === "S";
          d.className = "cap " + (split ? "split" : "full");
          d.id = "cap" + i;
          const st = c[2].match(/^\{([^|]*)\|([^|]*)\|([^}]*)\}$/);
          if (st) {
            d.innerHTML = `<div class="stack ${c[3]}">${st[1] ? `<span class="st-t w">${esc(st[1])}</span>` : ""}<span class="st-B w">${esc(st[2])}</span>${st[3] ? `<span class="st-b w">${esc(st[3])}</span>` : ""}</div>`;
            d.dataset.kind = "stack";
            // long glow words step down so they stay on one line
            const big = d.querySelector(".st-B"), n = st[2].length;
            big.style.fontSize = n > 16 ? "92px" : n > 10 ? "112px" : "";
          } else {
            const toks = c[2].match(/\[[^\]]+\][^ ]*|![^!]+!|~[^~]+~[^ ]*|_[^_]+_[^ ]*|[^ ]+/g) || [];
            d.innerHTML = toks.map((tk) => {
              if (tk[0] === "[") { const m = tk.match(/^\[([^\]]+)\](.*)$/); return `<span class="w bar">${esc(m[1])}</span>${m[2] ? `<span class="w">${esc(m[2])}</span>` : ""}`; }
              if (tk[0] === "!") return `<span class="w rbar">${esc(tk.slice(1, -1))}</span>`;
              if (tk[0] === "~") { const m = tk.match(/^~([^~]+)~(.*)$/); return `<span class="w hand">${esc(m[1])}</span>${m[2] ? `<span class="w">${esc(m[2])}</span>` : ""}`; }
              if (tk[0] === "_") { const m = tk.match(/^_([^_]+)_(.*)$/); return `<span class="w it">${esc(m[1])}${esc(m[2])}</span>`; }
              return `<span class="w">${esc(tk)}</span>`;
            }).join("");
            d.dataset.kind = "line";
          }
          capRoot.appendChild(d);
        });

        // ---------- timeline ----------
        const tl = gsap.timeline({ paused: true });
        const E = "expo.out";
        const count = (el, from, to, t, d, fmt = (v) => Math.round(v).toLocaleString("en-IN")) => {
          const o = { v: from };
          tl.fromTo(o, { v: from }, { v: to, duration: d, ease: "power3.out", onUpdate: () => { el.textContent = fmt(o.v); } }, t);
        };
        const enter = (el, t, o = {}) => tl.fromTo(el, { y: o.y ?? 70, opacity: 0, scale: o.s ?? 0.94, rotation: o.r ?? 0, filter: "blur(10px)" }, { y: 0, opacity: 1, scale: 1, rotation: o.r2 ?? 0, filter: "blur(0px)", duration: o.d ?? 0.6, ease: E, stagger: o.st ?? 0 }, t);
        const flash = (t, a = 0.85) => tl.fromTo("#flash", { opacity: a }, { opacity: 0, duration: 0.35, ease: "power2.out", immediateRender: false }, t);
        const ZOOM = "#vzoom, #mzoom", FRAME = "#vframe, #mframe";

        // ---- camera morph: full frame <-> bottom card with the head popping out over its top edge ----
        const FULL = { v: "inset(0px 0px 0px 0px round 0px)", m: "inset(0px 0px 0px 0px)", y: 0, s: 1 };
        const CARD = { v: "inset(900px 44px 40px 44px round 44px)", m: "inset(0px 44px 40px 44px)", y: 285, s: 0.86 };
        tl.set("#vclip", { clipPath: FULL.v }, 0);
        tl.set("#mclip", { clipPath: FULL.m }, 0);
        tl.set(FRAME, { y: 0, scale: 1 }, 0);
        LAYOUT.forEach(([t0, l], i) => {
          if (i === 0) return;
          const s = l === "S" ? CARD : FULL, t = T(t0);
          tl.to("#vclip", { clipPath: s.v, duration: 0.45, ease: "expo.inOut" }, t - 0.08);
          tl.to("#mclip", { clipPath: s.m, duration: 0.45, ease: "expo.inOut" }, t - 0.08);
          tl.to(FRAME, { y: s.y, scale: s.s, duration: 0.45, ease: "expo.inOut" }, t - 0.08);
        });

        // ---- zoom grammar: punch in on the word, release with a zoom-out ----
        const punch = (t, z = 1.16, hold = 0.5) => {
          tl.to(ZOOM, { scale: z, duration: 0.16, ease: "power3.out" }, t);
          tl.to(ZOOM, { scale: 1.0, duration: 0.55, ease: "expo.out" }, t + hold);
        };
        // hook: riser build, drop, flash, shake
        tl.fromTo(ZOOM, { scale: 1.0 }, { scale: 1.32, duration: 1.5, ease: "power2.in" }, 0);
        tl.to(ZOOM, { scale: 1.0, duration: 0.55, ease: "expo.out" }, 1.5);
        tl.fromTo(ZOOM, { x: -14 }, { x: 14, duration: 0.04, repeat: 7, yoyo: true, ease: "none" }, 1.5);
        tl.set(ZOOM, { x: 0 }, 1.82);
        flash(1.5, 0.9);
        punch(T(2.55), 1.14, 0.7);
        // DAY 2 behind the head
        tl.set("#behind", { opacity: 1 }, T(3.86));
        tl.fromTo("#beh-pill", { y: -60, opacity: 0 }, { y: 0, opacity: 1, duration: 0.5, ease: E }, T(3.9));
        tl.fromTo("#beh-day", { scale: 1.5, opacity: 0, filter: "blur(18px)" }, { scale: 1, opacity: 1, filter: "blur(0px)", duration: 0.7, ease: E }, T(4.9));
        tl.to("#behind", { opacity: 0, duration: 0.25 }, T(5.9));
        punch(T(19.6), 1.14, 1.1);
        punch(T(21.2), 1.08, 0.6);
        tl.to(ZOOM, { scale: 1.08, duration: T(33.4) - T(27.0), ease: "sine.inOut" }, T(27.0));
        tl.to(ZOOM, { scale: 1.24, duration: 0.18, ease: "power3.out" }, T(34.4));
        tl.to(ZOOM, { scale: 1.0, duration: 0.6, ease: "expo.out" }, T(35.25));
        flash(T(34.42), 0.45);
        punch(T(68.05), 1.2, 0.5);
        tl.fromTo(ZOOM, { x: -18 }, { x: 18, duration: 0.03, repeat: 7, yoyo: true, ease: "none" }, T(68.05));
        tl.set(ZOOM, { x: 0 }, T(68.05) + 0.25);
        tl.fromTo("#redwash", { opacity: 1 }, { opacity: 0, duration: 0.9, ease: "power2.out", immediateRender: false }, T(68.05));
        tl.to(ZOOM, { scale: 1.06, duration: 3.4, ease: "sine.inOut" }, T(74.7));
        tl.to(ZOOM, { scale: 1.0, duration: 0.5, ease: "expo.out" }, T(78.3));
        punch(T(80.5), 1.12, 0.6);

        // ---- captions ----
        CAPS.forEach((c, i) => {
          const el = $("#cap" + i), t0 = T(c[0]), t1 = T(c[1]);
          tl.set(el, { opacity: 1 }, t0);
          if (el.dataset.kind === "stack") {
            const small = el.querySelectorAll(".st-t, .st-b"), big = el.querySelector(".st-B");
            if (small.length) tl.fromTo(small, { y: 16, opacity: 0 }, { y: 0, opacity: 1, duration: 0.3, ease: "power3.out", stagger: 0.12 }, t0);
            tl.fromTo(big, { scale: 1.45, opacity: 0, filter: "blur(10px)" }, { scale: 1, opacity: 1, filter: "blur(0px)", duration: 0.35, ease: "back.out(1.8)" }, t0 + 0.08);
          } else {
            const ws = el.querySelectorAll(".w"), st = Math.min(0.055, ((t1 - t0) * 0.3) / Math.max(1, ws.length));
            tl.fromTo(ws, { y: 22, opacity: 0 }, { y: 0, opacity: 1, duration: 0.2, ease: "power3.out", stagger: st }, t0);
            const bars = el.querySelectorAll(".bar, .rbar");
            if (bars.length) tl.fromTo(bars, { clipPath: "inset(0% 100% 0% 0%)" }, { clipPath: "inset(0% 0% 0% 0%)", duration: 0.28, ease: "power3.out" }, t0 + 0.04);
          }
          tl.set(el, { opacity: 0 }, t1);
        });

        // ---- P1: previously on day 1 ----
        tl.fromTo("#m-d1a", { opacity: 0, y: 120, rotation: -9, scale: 0.9 }, { opacity: 1, y: 0, rotation: -4, scale: 1, duration: 0.6, ease: E }, T(6.3));
        tl.to("#m-d1a", { opacity: 0, x: -200, rotation: -14, duration: 0.3, ease: "power2.in" }, T(10.45));
        tl.fromTo("#m-d1b", { opacity: 0, x: 220, rotation: 10 }, { opacity: 1, x: 0, rotation: 3, duration: 0.5, ease: E }, T(10.6));
        tl.to("#m-d1b", { opacity: 0, duration: 0.2 }, T(14.85));
        enter("#p1-chip", T(6.4), { y: -30, r: -10, r2: -4 });
        tl.fromTo("#p1-twins", { x: -300, rotation: -20 }, { x: 0, rotation: -6, duration: 0.6, ease: "back.out(1.6)" }, T(8.3));
        tl.fromTo("#p1-tags .tag", { x: 80, opacity: 0 }, { x: 0, opacity: 1, duration: 0.4, ease: "back.out(2)", stagger: 0.45 }, T(10.8));

        // ---- P2: the hurried prompt ----
        enter("#p2-app", T(14.9), { r: 3 });
        tl.fromTo(".p2-l", { opacity: 0, x: -30 }, { opacity: 1, x: 0, duration: 0.3, ease: E, stagger: 0.3 }, T(15.2));
        tl.fromTo("#p2-slot", { backgroundColor: "rgba(255,69,69,0)" }, { backgroundColor: "rgba(255,69,69,0.25)", duration: 0.2, yoyo: true, repeat: 7, ease: "steps(1)" }, T(17.4));
        tl.fromTo("#p2-warn", { scale: 0.4, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.4, ease: "back.out(2.4)" }, T(17.6));
        tl.fromTo("#p2-send", { scale: 1 }, { scale: 0.88, duration: 0.1, yoyo: true, repeat: 1 }, T(18.6));
        tl.to("#p2-app", { x: 1200, rotation: 10, duration: 0.45, ease: "power3.in" }, T(18.85));

        // ---- O1: veg chicken biryani ----
        tl.fromTo("#o1-pip", { y: -200, opacity: 0, scale: 0.9 }, { y: 0, opacity: 1, scale: 1, duration: 0.55, ease: E }, T(19.55));
        tl.fromTo("#o1-img", { scale: 1.0 }, { scale: 1.15, duration: T(22.66) - T(19.5), ease: "none" }, T(19.5));
        tl.fromTo("#pb-o1", { scaleX: 0 }, { scaleX: 1, duration: T(22.66) - T(19.55), ease: "none" }, T(19.55));
        tl.fromTo("#o1-veg", { scale: 2.4, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.25, ease: "power4.in" }, T(20.5));
        tl.fromTo("#o1-chk", { scale: 2.4, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.25, ease: "power4.in" }, T(20.95));
        tl.fromTo("#o1-q", { scale: 0, rotation: -30 }, { scale: 1, rotation: 6, duration: 0.4, ease: "back.out(3)" }, T(21.5));

        // ---- P3: memes ----
        tl.fromTo(".p3-m", { y: 380, opacity: 0, rotation: 0 }, { y: 0, opacity: 1, rotation: (k) => [-4, 5, -1.5][k], duration: 0.55, ease: "back.out(1.4)", stagger: 0.32 }, T(22.7));
        $$(".p3-like").forEach((el, i) => count(el, 0, [12400, 8600, 23100][i], T(23.0) + i * 0.32, 2.4, (v) => (v >= 1000 ? (v / 1000).toFixed(1) + "K" : Math.round(v) + "")));
        tl.fromTo(".p3-e", { y: 80, opacity: 0, scale: 0.4 }, { y: -120, opacity: 1, scale: 1.1, duration: 0.7, ease: "back.out(2)", stagger: { each: 0.08, from: "random" } }, T(24.2));
        tl.to(".p3-e", { y: -260, opacity: 0, duration: 0.5, ease: "power1.in", stagger: { each: 0.05, from: "random" } }, T(24.2) + 1.5);

        // ---- O2: thought bubble, detail vs result ----
        tl.fromTo(".o2-dot", { scale: 0 }, { scale: 1, duration: 0.3, ease: "back.out(3)", stagger: -0.12 }, T(26.8));
        tl.fromTo("#o2-cloud", { scale: 0.3, opacity: 0, transformOrigin: "50% 90%" }, { scale: 1, opacity: 1, duration: 0.55, ease: "back.out(1.6)" }, T(27.0));
        tl.fromTo("#o2-bar", { scaleX: 0 }, { scaleX: 0.98, duration: 2.0, ease: "power2.out" }, T(27.4));
        tl.fromTo("#o2-x", { scale: 0.3, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.4, ease: "back.out(2.6)" }, T(31.0));

        // ---- P4: recipe ----
        tl.fromTo("#p4-photo", { y: 100, opacity: 0, rotation: 3 }, { y: 0, opacity: 1, rotation: 0, duration: 0.6, ease: E }, T(35.5));
        tl.fromTo("#p4-img", { scale: 1.0 }, { scale: 1.12, duration: T(43.1) - T(35.5), ease: "none" }, T(35.5));
        tl.fromTo("#p4-list", { y: 60, opacity: 0, rotation: -6 }, { y: 0, opacity: 1, rotation: -2, duration: 0.5, ease: "back.out(1.8)" }, T(37.3));
        tl.fromTo(".p4-li", { x: -30, opacity: 0 }, { x: 0, opacity: 1, duration: 0.3, ease: E, stagger: 0.35 }, T(37.5));
        tl.to("#p4-list", { opacity: 0, y: -40, duration: 0.3 }, T(40.3));
        tl.fromTo(".p4-day", { y: 60, opacity: 0 }, { y: 0, opacity: 1, duration: 0.35, ease: "back.out(2)", stagger: 0.12 }, T(40.45));

        // ---- O3 / P5 screen recordings ----
        tl.fromTo("#m-rec1", { opacity: 0, y: -160, scale: 0.92 }, { opacity: 1, y: 0, scale: 1, duration: 0.55, ease: E }, T(43.15));
        tl.fromTo("#pb-rec1", { scaleX: 0 }, { scaleX: 1, duration: T(47.0) - T(43.15), ease: "none" }, T(43.15));
        tl.to("#m-rec1", { opacity: 0, duration: 0.2 }, T(46.85));
        enter("#o3-chip", T(43.4), { y: -20 });
        tl.fromTo("#m-rec2", { opacity: 0, y: 120, rotation: 2 }, { opacity: 1, y: 0, rotation: 0, duration: 0.55, ease: E }, T(47.05));
        tl.to("#m-rec2", { opacity: 0, y: -60, duration: 0.3, ease: "power2.in" }, T(51.8));
        tl.fromTo("#p5-line", { strokeDasharray: 1300, strokeDashoffset: 1300 }, { strokeDashoffset: 0, duration: 1.4, ease: "power2.out" }, T(52.15));
        tl.fromTo("#p5-area", { opacity: 0 }, { opacity: 1, duration: 0.8 }, T(52.6));
        tl.fromTo(".p5-out", { scale: 0, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.4, ease: "back.out(2.4)", stagger: 0.45 }, T(53.2));
        enter("#p5-lbl", T(52.3), { y: -20 });

        // ---- P6: poster from one line ----
        enter("#p6-chat", T(58.8));
        tl.fromTo("#p6-using", { scale: 0.5, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.4, ease: "back.out(2.4)" }, T(62.4));
        tl.fromTo("#p6-poster", { scale: 0.5, rotationY: -35, transformPerspective: 1600, opacity: 0, filter: "blur(14px)" }, { scale: 1, rotationY: 0, opacity: 1, filter: "blur(0px)", duration: 0.75, ease: E }, T(64.6));
        tl.fromTo("#p6-sweep", { x: 0 }, { x: 900, duration: 0.9, ease: "power2.inOut" }, T(65.4));
        tl.fromTo("#p6-ok", { scale: 0, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.4, ease: "back.out(3)" }, T(66.0));

        // ---- P7: every weekend ----
        tl.fromTo(".p7-w", { scale: 0.5 }, { scale: 1, backgroundColor: "#ffd60a", duration: 0.2, ease: "back.out(2)", stagger: 0.035 }, T(70.2));
        count($("#p7-num"), 0, 52, T(70.2), 2.0);
        tl.fromTo("#p7-hand", { rotation: 0 }, { rotation: 1080, duration: T(74.6) - T(70.0), ease: "none" }, T(70.0));

        // ---- O4 tease, O5 name, O6 follow ----
        tl.fromTo(".o4-dot", { scale: 0 }, { scale: 1, duration: 0.3, ease: "back.out(3)", stagger: -0.12 }, T(74.7));
        tl.fromTo("#o4-cloud", { scale: 0.3, opacity: 0, transformOrigin: "50% 90%" }, { scale: 1, opacity: 1, duration: 0.55, ease: "back.out(1.6)" }, T(74.9));
        tl.fromTo("#o4-next", { filter: "blur(14px)" }, { filter: "blur(6px)", duration: 1.4, yoyo: true, repeat: 1, ease: "sine.inOut" }, T(75.6));
        enter("#o4-day", T(76.2), { r: 14, r2: 6 });
        tl.fromTo("#o5-name", { x: -600, opacity: 0 }, { x: 0, opacity: 1, duration: 0.6, ease: E }, T(78.35));
        enter("#o6-btns", T(79.95), { y: -40 });
        tl.fromTo("#o6-f", { scale: 1 }, { scale: 1.08, duration: 0.3, yoyo: true, repeat: 3, ease: "sine.inOut" }, T(80.4));

        window.__timelines["main"] = tl;
      })();
    </script>
  </body>
</html>
