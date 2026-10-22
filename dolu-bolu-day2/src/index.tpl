<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Dolu Bolu Day 2</title>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.14.2/dist/gsap.min.js"></script>
    <style>
      @font-face { font-family: "MontserratV"; src: url("assets/fonts/Montserrat-VF.ttf") format("truetype"); font-weight: 100 900; }
      @font-face { font-family: "PoppinsXB"; src: url("assets/fonts/Poppins-ExtraBold.ttf") format("truetype"); font-weight: 800; }
      @font-face { font-family: "PoppinsB"; src: url("assets/fonts/Poppins-Bold.ttf") format("truetype"); font-weight: 700; }
      @font-face { font-family: "PoppinsSB"; src: url("assets/fonts/Poppins-SemiBold.ttf") format("truetype"); font-weight: 600; }
      @font-face { font-family: "PoppinsM"; src: url("assets/fonts/Poppins-Medium.ttf") format("truetype"); font-weight: 500; }
      @font-face { font-family: "Anton"; src: url("assets/fonts/Anton-Regular.ttf") format("truetype"); }
      @font-face { font-family: "Marker"; src: url("assets/fonts/PermanentMarker-Regular.ttf") format("truetype"); }
      @font-face { font-family: "PlayfairI"; src: url("assets/fonts/PlayfairDisplay-Italic-VF.ttf") format("truetype"); font-weight: 400 900; font-style: italic; }
      @font-face { font-family: "JBMono"; src: url("assets/fonts/JetBrainsMono-VF.ttf") format("truetype"); font-weight: 100 800; }
      :root {
        --saffron: #ff9933; --gold: #ffb627; --brown: #3b1f0e; --ink: #14110f; --paper: #f4f1ec;
        --red: #ff3b30; --green: #19c37d; --blue: #2d7bff; --violet: #7c5cff; --cyan: #29d3ff;
        --glass: rgba(255,255,255,0.74); --line: rgba(20,17,15,0.08);
        --shadow: 0 1px 2px rgba(20,17,15,0.06), 0 8px 24px rgba(20,17,15,0.08), 0 32px 80px rgba(20,17,15,0.14);
      }
      * { margin: 0; padding: 0; box-sizing: border-box; }
      html, body { width: 1080px; height: 1920px; overflow: hidden; background: var(--paper); }
      #root { position: relative; width: 100%; height: 100%; overflow: hidden; font-family: "PoppinsSB", sans-serif; color: var(--ink); }
      .clip { position: absolute; inset: 0; }
      .abs { position: absolute; }
      .xb { font-family: "PoppinsXB", sans-serif; }
      .b { font-family: "PoppinsB", sans-serif; }
      .m { font-family: "PoppinsM", sans-serif; }
      .mono { font-family: "JBMono", monospace; }

      #paper { z-index: 0; background:
          radial-gradient(120% 70% at 50% 20%, rgba(255,182,39,0.10), transparent 60%),
          linear-gradient(var(--line) 1.5px, transparent 1.5px) 0 0 / 60px 60px,
          linear-gradient(90deg, var(--line) 1.5px, transparent 1.5px) 0 0 / 60px 60px,
          var(--paper); }

      /* camera: clip box > layout transform > zoom > [video, behind-text, subject matte] */
      #vclip { position: absolute; inset: 0; z-index: 2; overflow: hidden; }
      #vframe { position: absolute; inset: 0; transform-origin: 50% 0%; }
      #vzoom { position: absolute; inset: 0; transform-origin: 50% 38%; }
      #talk, #matte { position: absolute; inset: 0; width: 100%; height: 100%; object-fit: cover; }
      #vgrade { position: absolute; inset: 0; background: linear-gradient(180deg, transparent 60%, rgba(10,6,2,0.42) 100%); }
      #behind { position: absolute; left: 0; right: 0; top: 150px; text-align: center; }
      #flash { position: absolute; inset: 0; z-index: 7; background: #fff; opacity: 0; pointer-events: none; }
      #rgb { position: absolute; inset: 0; z-index: 7; pointer-events: none; opacity: 0; mix-blend-mode: screen;
             background: repeating-linear-gradient(180deg, rgba(255,0,60,0.18) 0 6px, rgba(0,255,255,0.12) 6px 12px, transparent 12px 18px); }

      .panel { position: absolute; left: 0; right: 0; top: 0; height: 790px; z-index: 3; overflow: hidden; }
      .pz { position: absolute; inset: 0; transform: scale(0.9); transform-origin: 50% 0%; }
      .overlay { position: absolute; left: 0; right: 0; top: 0; height: 900px; z-index: 3; }
      .solid { background: #fff; border: 1.5px solid rgba(20,17,15,0.06); border-radius: 36px; box-shadow: var(--shadow); }
      .glass { background: var(--glass); border: 1.5px solid rgba(255,255,255,0.9); border-radius: 36px; box-shadow: var(--shadow); }
      .tech { background: linear-gradient(160deg, #141a3a 0%, #0b0e22 100%); border: 1.5px solid rgba(124,92,255,0.45); border-radius: 36px; box-shadow: 0 30px 80px rgba(20,20,60,0.35), inset 0 1px 0 rgba(255,255,255,0.08); }
      .eyebrow { font-family: "PoppinsB"; font-size: 24px; letter-spacing: 5px; text-transform: uppercase; color: rgba(20,17,15,0.5); }
      .chip { display: inline-flex; align-items: center; gap: 12px; padding: 12px 24px; border-radius: 999px; font-family: "PoppinsB"; font-size: 28px; }
      .sweep { position: absolute; top: -20%; bottom: -20%; width: 160px; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.75), transparent); transform: skewX(-18deg); pointer-events: none; }
      .poster { border-radius: 24px; background: linear-gradient(160deg,#fffaf0,#ffe9c7); box-shadow: var(--shadow); overflow: hidden; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; border: 1.5px solid rgba(255,255,255,0.9); }
      .code { font-family: "JBMono"; font-size: 30px; line-height: 1.55; color: #d6dcff; white-space: pre; }
      .code .k { color: #ff9eb5; } .code .s { color: #a6f0c6; } .code .c { color: #6f78a8; } .code .n { color: #ffd479; }

      /* ---------- caption styles ---------- */
      #captions { z-index: 6; pointer-events: none; }
      .cap { position: absolute; left: 40px; right: 40px; display: flex; flex-wrap: wrap; justify-content: center; align-items: center; gap: 10px 18px; opacity: 0; text-align: center; }
      .cap.full { top: 1370px; }
      .cap.split { top: 712px; }
      .cap .w { display: inline-block; transform-origin: 50% 85%; }
      /* base: bold caps, outline, highlight box */
      .st-base .w { font-family: "MontserratV"; font-weight: 900; text-transform: uppercase; letter-spacing: -1px; font-size: 74px; line-height: 1.08; color: #fff; paint-order: stroke fill; -webkit-text-stroke: 12px #0b0806; text-shadow: 0 10px 28px rgba(0,0,0,0.4); }
      .cap.split.st-base .w { font-size: 60px; -webkit-text-stroke: 10px #0b0806; }
      .st-base .w.k, .st-base .w.r { -webkit-text-stroke: 0; padding: 4px 22px 8px; border-radius: 16px; text-shadow: none; box-shadow: 0 12px 30px rgba(0,0,0,0.35), inset 0 -4px 0 rgba(0,0,0,0.12); }
      .st-base .w.k { color: #1a1206; background: linear-gradient(180deg, #ffc93c, #ff9f1c); }
      /* highlight boxes never take the outline, whatever the layout */
      .cap.st-base .w.k, .cap.st-base .w.r, .cap.st-hook .w.r { -webkit-text-stroke: 0 !important; paint-order: normal; }
      .st-base .w.r { color: #fff; background: linear-gradient(180deg, #ff5a4f, #e0261a); }
      /* hook: oversized, tighter */
      .st-hook .w { font-family: "MontserratV"; font-weight: 900; text-transform: uppercase; letter-spacing: -2px; font-size: 92px; line-height: 1.02; color: #fff; paint-order: stroke fill; -webkit-text-stroke: 14px #0b0806; text-shadow: 0 14px 34px rgba(0,0,0,0.45); }
      .st-hook .w.k { color: var(--gold); }
      .st-hook .w.r { color: #fff; -webkit-text-stroke: 0; background: linear-gradient(180deg,#ff5a4f,#e0261a); padding: 2px 22px 10px; border-radius: 18px; box-shadow: 0 14px 34px rgba(0,0,0,0.4); }
      /* marker: hand-written joke voice */
      .st-marker .w { font-family: "Marker"; font-size: 78px; line-height: 1.1; color: #fff; paint-order: stroke fill; -webkit-text-stroke: 10px #0b0806; text-shadow: 0 8px 22px rgba(0,0,0,0.4); }
      .cap.split.st-marker .w { font-size: 62px; }
      .st-marker .w.k { color: #ffe14d; }
      .st-marker .w.r { color: #ff6b5e; }
      /* editorial: italic serif, reflective */
      .st-editorial .w { font-family: "PlayfairI"; font-style: italic; font-weight: 600; font-size: 80px; line-height: 1.08; color: #fff; text-shadow: 0 4px 24px rgba(0,0,0,0.65), 0 1px 3px rgba(0,0,0,0.6); }
      .st-editorial .w.k { font-weight: 900; color: #ffc93c; }
      /* terminal: mono on a glass console */
      .st-terminal { padding: 22px 30px; border-radius: 22px; background: rgba(8,10,24,0.82); border: 1.5px solid rgba(41,211,255,0.5); box-shadow: 0 20px 50px rgba(0,0,0,0.45), 0 0 40px rgba(41,211,255,0.25); left: 90px; right: 90px; }
      .st-terminal .w { font-family: "JBMono"; font-weight: 800; font-size: 60px; color: #7cf5ff; text-shadow: 0 0 18px rgba(41,211,255,0.7); }
      .st-terminal .w.k { color: #ffd479; text-shadow: 0 0 18px rgba(255,212,121,0.7); }
      /* glitch: RGB split punch */
      .st-glitch .w { font-family: "Anton"; font-size: 120px; line-height: 1.0; letter-spacing: 1px; color: #fff; text-transform: uppercase; text-shadow: 6px 0 0 rgba(255,0,70,0.85), -6px 0 0 rgba(0,240,255,0.85), 0 14px 30px rgba(0,0,0,0.5); }
      .st-glitch .w.k { color: #ff4436; }
      .cap.split.st-glitch .w { font-size: 84px; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="main" data-start="0" data-width="1080" data-height="1920" data-duration="{{T:81.55}}">
      <div id="paper" class="clip"></div>

      <div id="vclip">
        <div id="vframe"><div id="vzoom">
          <video id="talk" src="assets/media/talk-cut.mp4" muted playsinline data-start="0" data-duration="{{T:81.55}}" data-track-index="0"></video>
          <div id="behind">
            <div id="beh-pill" style="display:inline-flex; align-items:center; gap:14px; padding:14px 30px; border-radius:999px; background:#14110f; color:#fff; font-family:PoppinsB; font-size:30px; letter-spacing:3px;"><span style="width:18px; height:18px; border-radius:50%; background:linear-gradient(135deg,#29d3ff,#7c5cff); display:block;"></span>VANGA AI KATHUKALAM</div>
            <div id="beh-day" style="font-family:Anton; font-size:430px; line-height:0.95; color:#fff; letter-spacing:4px; margin-top:6px; text-shadow:0 20px 60px rgba(0,0,0,0.35); -webkit-text-stroke:3px rgba(255,153,51,0.9);">DAY 2</div>
          </div>
          <video id="matte" src="assets/media/hook-matte.webm" muted playsinline data-start="0" data-duration="6.0" data-track-index="1"></video>
          <div id="vgrade"></div>
        </div></div>
      </div>

      <!-- ================= SPLIT PANELS ================= -->

      <!-- Previously on: Day 1 recap, lesson learnt -->
      <section id="p1" class="panel clip" data-start="{{T:6.2}}" data-duration="{{D:6.2:14.9}}" data-track-index="2"><div class="pz">
        <div class="abs solid" id="p1-card" style="left:60px; right:60px; top:70px; height:700px; padding:46px 52px; overflow:hidden;">
          <div class="eyebrow">Previously on Vanga AI Kathukalam</div>
          <div style="display:flex; gap:34px; margin-top:26px; align-items:center;">
            <div class="poster" id="p1-poster" style="width:250px; height:310px; flex:none; position:relative;">
              <div class="xb" style="font-size:56px; line-height:0.95; color:var(--brown);">BUY 1</div><div class="xb" style="font-size:56px; line-height:0.95; color:var(--saffron);">GET 1</div><div class="xb" style="font-size:64px; line-height:0.95; color:#e0261a;">FREE!</div>
              <div class="abs xb" id="p1-loss" style="left:-14px; top:120px; padding:4px 16px; font-size:40px; color:#fff; background:#e0261a; border-radius:12px; transform:rotate(-12deg); box-shadow:0 10px 24px rgba(224,38,26,0.4);">FULL LOSS</div>
            </div>
            <img id="p1-twins" src="assets/twins.png" alt="Dolu and Bolu" style="height:300px; width:auto; filter:drop-shadow(0 14px 22px rgba(20,17,15,0.22));" />
          </div>
          <div id="p1-lesson" class="abs" style="left:52px; right:52px; top:440px;">
            <div class="b" style="font-size:30px; color:rgba(20,17,15,0.55); margin-bottom:14px;">Lesson learnt 📒</div>
            <div class="p1-row" style="display:flex; align-items:center; gap:18px; font-family:PoppinsB; font-size:40px; margin-bottom:12px;"><span class="p1-tick" style="width:52px; height:52px; border-radius:50%; background:var(--green); color:#fff; display:grid; place-items:center; font-size:30px;">✓</span>Good context</div>
            <div class="p1-row" style="display:flex; align-items:center; gap:18px; font-family:PoppinsB; font-size:40px;"><span class="p1-tick" style="width:52px; height:52px; border-radius:50%; background:var(--green); color:#fff; display:grid; place-items:center; font-size:30px;">✓</span>Detailed prompts only</div>
          </div>
        </div>
      </div></section>

      <!-- The hurried prompt: biryani type missing -->
      <section id="p2" class="panel clip" data-start="{{T:14.9}}" data-duration="{{D:14.9:19.5}}" data-track-index="2"><div class="pz">
        <div class="abs solid" id="p2-card" style="left:60px; right:60px; top:70px; height:700px; padding:44px 48px; overflow:hidden;">
          <div style="display:flex; justify-content:space-between; align-items:center;"><span class="eyebrow">Prompt · in a hurry</span><span class="chip" id="p2-hurry" style="background:#fff3df; color:#a8560c; font-size:24px;">⏱ avasara avasarama</span></div>
          <div id="p2-text" class="m" style="font-size:38px; line-height:1.5; margin-top:24px; color:#2a2622;">
            <div class="p2-l">Make a <b>weekend poster</b> for</div>
            <div class="p2-l"><b>Dolu Bolu Biryani Kadai</b>.</div>
            <div class="p2-l">Budget ₹2,000 · Goal: more profit.</div>
            <div class="p2-l">Offer: 20% off on <span id="p2-slot" style="display:inline-block; min-width:210px; border-bottom:6px solid #e0261a; color:#e0261a; text-align:center;">?????</span> biryani.</div>
          </div>
          <div class="abs chip" id="p2-warn" style="left:48px; bottom:44px; background:#e0261a; color:#fff; font-size:30px; box-shadow:0 14px 36px rgba(224,38,26,0.45);">⚠ Missing: which biryani?</div>
          <div class="abs chip" id="p2-send" style="right:48px; bottom:44px; background:linear-gradient(135deg,var(--blue),var(--violet)); color:#fff; font-size:30px;">Send ➜</div>
        </div>
      </div></section>

      <!-- Memes -->
      <section id="p3" class="panel clip" data-start="{{T:22.66}}" data-duration="{{D:22.66:26.72}}" data-track-index="2"><div class="pz">
        <div class="abs chip" id="p3-trend" style="left:0; right:0; top:60px; margin:auto; width:max-content; background:#14110f; color:#fff; font-size:28px;">🔥 Trending #1 · Chennai</div>
        <div class="abs solid p3-m" style="left:70px; top:150px; width:470px; padding:26px 28px; transform:rotate(-4deg);">
          <div style="display:flex; align-items:center; gap:12px;"><div style="width:48px; height:48px; border-radius:50%; background:linear-gradient(135deg,#ff9933,#e0261a);"></div><span class="b" style="font-size:24px;">@biryani_memes</span></div>
          <div class="b" style="font-size:40px; line-height:1.2; margin-top:14px;">“Veg chicken biryani” 🥦🍗 innovation level 💀</div>
          <div class="m" style="font-size:24px; color:rgba(20,17,15,0.55); margin-top:12px;">❤ <span class="p3-like">0</span> · 💬 1.2K</div>
        </div>
        <div class="abs solid p3-m" style="left:560px; top:120px; width:440px; padding:26px 28px; transform:rotate(5deg);">
          <div style="display:flex; align-items:center; gap:12px;"><div style="width:48px; height:48px; border-radius:50%; background:linear-gradient(135deg,#2d7bff,#7c5cff);"></div><span class="b" style="font-size:24px;">@tamil_trolls</span></div>
          <div class="b" style="font-size:40px; line-height:1.2; margin-top:14px;">Pure veg-ku chicken free 😂</div>
          <div class="m" style="font-size:24px; color:rgba(20,17,15,0.55); margin-top:12px;">❤ <span class="p3-like">0</span> · 💬 860</div>
        </div>
        <div class="abs solid p3-m" style="left:250px; top:430px; width:560px; padding:26px 28px; transform:rotate(-1.5deg);">
          <div style="display:flex; align-items:center; gap:12px;"><div style="width:48px; height:48px; border-radius:50%; background:linear-gradient(135deg,#19c37d,#0f8a57);"></div><span class="b" style="font-size:24px;">@foodie_chennai</span></div>
          <div class="b" style="font-size:40px; line-height:1.2; margin-top:14px;">Dolu Bolu kadai: where AI cooks 🤖🍛</div>
          <div class="m" style="font-size:24px; color:rgba(20,17,15,0.55); margin-top:12px;">❤ <span class="p3-like">0</span> · 💬 3.4K</div>
        </div>
        <div id="p3-emoji" class="abs" style="left:0; top:0; width:1080px; height:790px;"></div>
      </div></section>

      <!-- Recipe card -->
      <section id="p4" class="panel clip" data-start="{{T:35.5}}" data-duration="{{D:35.5:43.1}}" data-track-index="2"><div class="pz">
        <div class="abs solid" id="p4-card" style="left:60px; width:560px; top:70px; height:700px; padding:40px 42px; overflow:hidden;">
          <div style="display:flex; align-items:center; gap:16px;"><span style="font-size:60px;">👨‍🍳</span><div><div class="eyebrow" style="font-size:20px;">Recipe card</div><div class="xb" style="font-size:40px; line-height:1.05;">Mutton Biryani</div></div></div>
          <div id="p4-steps" style="margin-top:22px; display:flex; flex-direction:column; gap:16px;"></div>
        </div>
        <div class="abs" id="p4-week" style="left:650px; right:60px; top:70px; height:700px; display:flex; flex-direction:column; gap:12px;"></div>
      </div></section>

      <!-- SKILL.md file, then same result every time -->
      <section id="p5" class="panel clip" data-start="{{T:47.0}}" data-duration="{{D:47.0:58.8}}" data-track-index="2"><div class="pz">
        <div class="abs tech" id="p5-ed" style="left:60px; right:60px; top:70px; height:700px; overflow:hidden;">
          <div style="height:72px; display:flex; align-items:center; gap:12px; padding:0 30px; border-bottom:1px solid rgba(255,255,255,0.08);">
            <i style="width:18px;height:18px;border-radius:50%;background:#ff5f57;display:block"></i><i style="width:18px;height:18px;border-radius:50%;background:#febc2e;display:block"></i><i style="width:18px;height:18px;border-radius:50%;background:#28c840;display:block"></i>
            <span class="mono" style="font-size:24px; color:#9aa3c7; margin-left:16px;">skills/sunday-poster/SKILL.md</span>
          </div>
          <div id="p5-code" class="code" style="padding:26px 34px;"></div>
        </div>
        <div class="abs" id="p5-flow" style="left:60px; right:60px; top:70px; height:700px; display:flex; align-items:center; justify-content:space-between;">
          <div class="tech" style="width:250px; height:300px; display:flex; flex-direction:column; align-items:center; justify-content:center; gap:10px;"><span style="font-size:90px;">📄</span><span class="mono" style="font-size:26px; color:#cfd6ff;">SKILL.md</span></div>
          <svg width="110" height="40" viewBox="0 0 110 40"><path class="p5-arr" d="M4 20 H96 M80 6 L98 20 L80 34" fill="none" stroke="#14110f" stroke-width="7" stroke-linecap="round" stroke-linejoin="round"/></svg>
          <div style="width:170px; height:170px; border-radius:46px; background:linear-gradient(135deg,var(--cyan),var(--violet)); display:grid; place-items:center; font-size:90px; box-shadow:0 0 60px rgba(124,92,255,0.6);">🤖</div>
          <svg width="110" height="40" viewBox="0 0 110 40"><path class="p5-arr" d="M4 20 H96 M80 6 L98 20 L80 34" fill="none" stroke="#14110f" stroke-width="7" stroke-linecap="round" stroke-linejoin="round"/></svg>
          <div id="p5-outs" style="display:flex; flex-direction:column; gap:14px;"></div>
        </div>
      </div></section>

      <!-- One line in, clear poster out -->
      <section id="p6" class="panel clip" data-start="{{T:58.8}}" data-duration="{{D:58.8:68.0}}" data-track-index="2"><div class="pz">
        <div class="abs solid" id="p6-chat" style="left:60px; right:60px; top:70px; height:220px; padding:30px 36px; display:flex; flex-direction:column; gap:18px;">
          <div style="align-self:flex-end; padding:16px 26px; border-radius:24px; border-bottom-right-radius:8px; background:linear-gradient(135deg,var(--blue),var(--violet)); color:#fff; font-family:PoppinsSB; font-size:34px;">Sunday special poster</div>
          <div id="p6-using" class="chip" style="align-self:flex-start; background:#eef3ff; color:#2d5bd8; font-size:26px;">⚡ Using skill: <b>sunday-poster</b></div>
        </div>
        <div class="abs poster" id="p6-poster" style="left:250px; top:320px; width:580px; height:450px; padding:30px; position:absolute;">
          <div class="eyebrow" style="color:#a8560c;">Dolu Bolu Biryani · Sunday Special</div>
          <div class="xb" style="font-size:96px; line-height:0.95; color:var(--brown); margin-top:10px;">MUTTON</div>
          <div class="xb" style="font-size:96px; line-height:0.95; color:var(--saffron);">BIRYANI</div>
          <div class="chip xb" style="margin-top:16px; background:#e0261a; color:#fff; font-size:32px;">BUY 1 GET 1 · first 50 plates</div>
          <div class="sweep" id="p6-sweep" style="left:-200px;"></div>
        </div>
        <div class="abs chip" id="p6-ok" style="left:780px; top:300px; background:var(--green); color:#fff; font-size:28px; box-shadow:0 14px 34px rgba(25,195,125,0.45);">✓ Clear</div>
      </div></section>

      <!-- Every weekend, by hand -->
      <section id="p7" class="panel clip" data-start="{{T:70.0}}" data-duration="{{D:70.0:74.6}}" data-track-index="2"><div class="pz">
        <div class="abs solid" style="left:60px; right:60px; top:70px; height:700px; padding:40px 44px; overflow:hidden;">
          <div style="display:flex; justify-content:space-between; align-items:center;"><span class="eyebrow">Every single weekend</span><span class="chip" style="background:#fdecea; color:#c4271c; font-size:24px;">🔁 manual</span></div>
          <div id="p7-grid" style="display:grid; grid-template-columns:repeat(13, 1fr); gap:10px; margin-top:26px;"></div>
          <div style="display:flex; align-items:center; gap:30px; margin-top:34px;">
            <div style="position:relative; width:150px; height:150px; border-radius:50%; background:#f4f1ec; border:6px solid #14110f; flex:none;">
              <div id="p7-hand" class="abs" style="left:69px; top:20px; width:6px; height:56px; background:#e0261a; border-radius:3px; transform-origin:50% 100%;"></div>
              <div class="abs" style="left:66px; top:66px; width:12px; height:12px; border-radius:50%; background:#14110f;"></div>
            </div>
            <div><div class="xb" style="font-size:96px; line-height:1;"><span id="p7-num">0</span></div><div class="b" style="font-size:30px; color:rgba(20,17,15,0.55);">weekends a year, by hand 😩</div></div>
          </div>
        </div>
      </div></section>

      <!-- ================= FULL-FRAME OVERLAYS ================= -->
      <div class="overlay clip" id="o1" data-start="{{T:19.5}}" data-duration="{{D:19.5:22.66}}" data-track-index="3">
        <div class="abs poster" id="o1-poster" style="left:300px; top:110px; width:480px; height:470px; padding:24px;">
          <div class="eyebrow" style="color:#a8560c;">AI output</div>
          <div class="xb" style="font-size:72px; line-height:1; color:#19a35d; margin-top:10px;">VEG 🥦</div>
          <div class="xb" style="font-size:72px; line-height:1; color:#e0261a;">CHICKEN 🍗</div>
          <div class="xb" style="font-size:72px; line-height:1; color:var(--brown);">BIRYANI</div>
        </div>
        <svg class="abs" id="o1-circle" viewBox="0 0 520 220" style="left:270px; top:250px; width:540px; height:230px; overflow:visible;"><path d="M40 120 C 30 40, 470 10, 495 100 C 520 190, 80 230, 30 140 C 10 100, 120 50, 260 40" fill="none" stroke="#ff3b30" stroke-width="10" stroke-linecap="round"/></svg>
        <div class="abs" id="o1-q" style="left:760px; top:70px; font-family:Marker; font-size:150px; color:#ff3b30; -webkit-text-stroke:6px #fff; paint-order:stroke fill;">?!</div>
      </div>
      <div class="overlay clip" id="o2" data-start="{{T:26.72}}" data-duration="{{D:26.72:33.5}}" data-track-index="3">
        <div class="abs glass" id="o2-card" style="left:110px; right:110px; top:120px; padding:32px 40px;">
          <div style="display:flex; justify-content:space-between; align-items:baseline;"><span class="eyebrow">Prompt detail</span><span class="xb" style="font-size:44px;"><span id="o2-pct">0</span>%</span></div>
          <div style="height:22px; border-radius:11px; background:rgba(20,17,15,0.08); margin-top:12px; overflow:hidden;"><div id="o2-bar" style="height:100%; width:100%; background:linear-gradient(90deg,var(--green),#7be3b1); transform-origin:0 50%;"></div></div>
          <div style="display:flex; justify-content:space-between; align-items:center; margin-top:22px;"><span class="eyebrow">Result</span><span class="chip xb" id="o2-res" style="background:#fdecea; color:#c4271c; font-size:30px;">✗ not what we expected</span></div>
        </div>
      </div>
      <div class="overlay clip" id="o3" data-start="{{T:34.3}}" data-duration="{{D:34.3:35.5}}" data-track-index="4" style="height:1920px; z-index:8;">
        <div class="abs" id="o3-bg" style="inset:0; background:#0b0806;"></div>
        <div class="abs" id="o3-sub" style="left:0; right:0; top:690px; text-align:center; font-family:PoppinsB; font-size:40px; letter-spacing:12px; color:rgba(255,255,255,0.55);">THE SOLUTION</div>
        <div class="abs" id="o3-word" style="left:0; right:0; top:740px; text-align:center; font-family:Anton; font-size:330px; line-height:1; color:#fff; letter-spacing:6px;">SKILLS</div>
        <div class="abs" id="o3-echo" style="left:0; right:0; top:740px; text-align:center; font-family:Anton; font-size:330px; line-height:1; color:transparent; -webkit-text-stroke:3px #ff9933; letter-spacing:6px;">SKILLS</div>
      </div>
      <div class="overlay clip" id="o4" data-start="{{T:43.1}}" data-duration="{{D:43.1:47.0}}" data-track-index="3">
        <div class="abs tech" id="o4-card" style="left:90px; right:90px; top:130px; padding:34px 40px;">
          <div class="mono" style="font-size:26px; color:#6f78a8;">// same idea, for AI</div>
          <div class="mono" style="font-size:44px; color:#cfd6ff; margin-top:12px;"><span style="color:#ff9eb5;">const</span> skill = <span id="o4-val" style="color:#a6f0c6;"></span><span id="o4-caret" style="display:inline-block; width:4px; height:44px; background:#7cf5ff; vertical-align:middle;"></span></div>
        </div>
      </div>
      <div class="overlay clip" id="o5" data-start="{{T:74.6}}" data-duration="{{D:74.6:78.3}}" data-track-index="3">
        <div class="abs glass" id="o5-card" style="left:110px; right:110px; top:120px; padding:34px 40px;">
          <div class="eyebrow">Vanga AI Kathukalam</div>
          <div id="o5-days" style="display:flex; gap:16px; margin-top:18px;"></div>
          <div style="display:flex; align-items:center; gap:16px; margin-top:22px;"><span class="b" style="font-size:28px; color:rgba(20,17,15,0.55);">Next:</span><span class="xb" id="o5-next" style="font-size:44px; letter-spacing:6px; filter:blur(9px);">AUTOMATION</span><span class="chip" style="background:#14110f; color:#fff; font-size:24px;">🔒 Day 3</span></div>
        </div>
      </div>
      <div class="overlay clip" id="o6" data-start="{{T:78.3}}" data-duration="{{D:78.3:79.9}}" data-track-index="3">
        <div class="abs glass" id="o6-card" style="left:90px; top:130px; padding:24px 40px 24px 24px; display:flex; align-items:center; gap:22px;">
          <div style="width:92px; height:92px; border-radius:24px; background:linear-gradient(135deg,var(--saffron),var(--gold)); display:grid; place-items:center;" class="xb"><span style="font-size:40px; color:#fff;">JC</span></div>
          <div><div class="xb" style="font-size:50px; line-height:1;">Joshua Collins</div><div class="m" style="font-size:28px; color:rgba(20,17,15,0.6); margin-top:6px;">Vanga AI Kathukalam · Day 2 of 5</div></div>
        </div>
      </div>
      <div class="overlay clip" id="o7" data-start="{{T:79.9}}" data-duration="{{D:79.9:81.55}}" data-track-index="3">
        <div class="abs" id="o7-btns" style="left:0; right:0; top:130px; display:flex; flex-direction:column; align-items:center; gap:18px;">
          <div style="display:flex; gap:18px;">
            <div class="chip xb" id="o7-f" style="font-size:40px; padding:22px 44px; background:linear-gradient(135deg,var(--saffron),var(--gold)); color:#fff; box-shadow:0 16px 40px rgba(255,153,51,0.45);">+ Follow</div>
            <div class="chip xb glass" id="o7-s" style="font-size:40px; padding:22px 44px;">🔖 Save</div>
          </div>
          <div class="chip b glass" style="font-size:30px;">📅 Day 3 next</div>
        </div>
      </div>

      <div id="captions" class="clip" data-start="0" data-duration="{{T:81.55}}" data-track-index="5"></div>
      <div id="flash"></div>
      <div id="rgb"></div>

      <audio id="vo" src="assets/media/vo-cut.m4a" data-start="0" data-duration="{{T:81.55}}" data-track-index="10" data-volume="1"></audio>
      <audio id="music" src="assets/media/music.m4a" data-start="0" data-duration="{{T:81.55}}" data-track-index="11" data-volume="0.08"></audio>
      <audio id="sfx-hook" src="assets/sfx/hook-riser.mp3" data-start="0" data-duration="2.9" data-track-index="19" data-volume="0.75"></audio>
      <audio id="sfx0" src="assets/sfx/whoosh-short.mp3" data-start="{{T:2.5}}" data-duration="1.0" data-track-index="20" data-volume="0.35"></audio>
      <audio id="sfx1" src="assets/sfx/click-soft.mp3" data-start="{{T:3.9}}" data-duration="1.0" data-track-index="21" data-volume="0.35"></audio>
      <audio id="sfx2" src="assets/sfx/impact-bass-1.mp3" data-start="{{T:4.9}}" data-duration="1.0" data-track-index="22" data-volume="0.55"></audio>
      <audio id="sfx3" src="assets/sfx/whoosh-short.mp3" data-start="{{T:6.2}}" data-duration="1.0" data-track-index="23" data-volume="0.22"></audio>
      <audio id="sfx4" src="assets/sfx/impact-bass-2.mp3" data-start="{{T:7.2}}" data-duration="1.0" data-track-index="20" data-volume="0.35"></audio>
      <audio id="sfx5" src="assets/sfx/click-soft.mp3" data-start="{{T:10.9}}" data-duration="1.0" data-track-index="21" data-volume="0.35"></audio>
      <audio id="sfx6" src="assets/sfx/click-soft.mp3" data-start="{{T:11.4}}" data-duration="1.0" data-track-index="22" data-volume="0.35"></audio>
      <audio id="sfx7" src="assets/sfx/typing.mp3" data-start="{{T:15.2}}" data-duration="2.0" data-track-index="23" data-volume="0.25"></audio>
      <audio id="sfx8" src="assets/sfx/error.mp3" data-start="{{T:17.6}}" data-duration="1.0" data-track-index="20" data-volume="0.3"></audio>
      <audio id="sfx9" src="assets/sfx/whoosh.mp3" data-start="{{T:18.6}}" data-duration="1.0" data-track-index="21" data-volume="0.35"></audio>
      <audio id="sfx10" src="assets/sfx/whoosh-short.mp3" data-start="{{T:19.5}}" data-duration="1.0" data-track-index="22" data-volume="0.22"></audio>
      <audio id="sfx11" src="assets/sfx/pop.mp3" data-start="{{T:19.6}}" data-duration="1.0" data-track-index="23" data-volume="0.45"></audio>
      <audio id="sfx12" src="assets/sfx/whoosh-short.mp3" data-start="{{T:20.8}}" data-duration="1.0" data-track-index="20" data-volume="0.3"></audio>
      <audio id="sfx13" src="assets/sfx/glitch-1.mp3" data-start="{{T:21.2}}" data-duration="1.0" data-track-index="21" data-volume="0.3"></audio>
      <audio id="sfx14" src="assets/sfx/whoosh-short.mp3" data-start="{{T:22.66}}" data-duration="1.0" data-track-index="22" data-volume="0.22"></audio>
      <audio id="sfx15" src="assets/sfx/pop.mp3" data-start="{{T:22.7}}" data-duration="1.0" data-track-index="23" data-volume="0.35"></audio>
      <audio id="sfx16" src="assets/sfx/pop.mp3" data-start="{{T:23.05}}" data-duration="1.0" data-track-index="20" data-volume="0.3"></audio>
      <audio id="sfx17" src="assets/sfx/pop.mp3" data-start="{{T:23.4}}" data-duration="1.0" data-track-index="21" data-volume="0.3"></audio>
      <audio id="sfx18" src="assets/sfx/sparkle.mp3" data-start="{{T:24.2}}" data-duration="1.0" data-track-index="22" data-volume="0.25"></audio>
      <audio id="sfx19" src="assets/sfx/whoosh-short.mp3" data-start="{{T:26.72}}" data-duration="1.0" data-track-index="23" data-volume="0.22"></audio>
      <audio id="sfx20" src="assets/sfx/error.mp3" data-start="{{T:31.0}}" data-duration="1.0" data-track-index="20" data-volume="0.3"></audio>
      <audio id="sfx21" src="assets/sfx/whoosh-cinematic.mp3" data-start="{{T:34.3}}" data-duration="1.0" data-track-index="21" data-volume="0.45"></audio>
      <audio id="sfx22" src="assets/sfx/impact-bass-2.mp3" data-start="{{T:34.42}}" data-duration="1.0" data-track-index="22" data-volume="0.75"></audio>
      <audio id="sfx23" src="assets/sfx/whoosh-short.mp3" data-start="{{T:35.5}}" data-duration="1.0" data-track-index="23" data-volume="0.22"></audio>
      <audio id="sfx24" src="assets/sfx/click-soft.mp3" data-start="{{T:37.4}}" data-duration="1.0" data-track-index="20" data-volume="0.3"></audio>
      <audio id="sfx25" src="assets/sfx/click-soft.mp3" data-start="{{T:37.8}}" data-duration="1.0" data-track-index="21" data-volume="0.3"></audio>
      <audio id="sfx26" src="assets/sfx/click-soft.mp3" data-start="{{T:38.2}}" data-duration="1.0" data-track-index="22" data-volume="0.3"></audio>
      <audio id="sfx27" src="assets/sfx/click-soft.mp3" data-start="{{T:38.6}}" data-duration="1.0" data-track-index="23" data-volume="0.3"></audio>
      <audio id="sfx28" src="assets/sfx/click-soft.mp3" data-start="{{T:39.0}}" data-duration="1.0" data-track-index="20" data-volume="0.3"></audio>
      <audio id="sfx29" src="assets/sfx/whoosh-short.mp3" data-start="{{T:40.4}}" data-duration="1.0" data-track-index="21" data-volume="0.25"></audio>
      <audio id="sfx30" src="assets/sfx/whoosh-short.mp3" data-start="{{T:43.1}}" data-duration="1.0" data-track-index="22" data-volume="0.22"></audio>
      <audio id="sfx31" src="assets/sfx/typing.mp3" data-start="{{T:43.5}}" data-duration="2.0" data-track-index="23" data-volume="0.25"></audio>
      <audio id="sfx32" src="assets/sfx/whoosh-short.mp3" data-start="{{T:47.0}}" data-duration="1.0" data-track-index="20" data-volume="0.22"></audio>
      <audio id="sfx33" src="assets/sfx/typing.mp3" data-start="{{T:47.4}}" data-duration="2.0" data-track-index="21" data-volume="0.25"></audio>
      <audio id="sfx34" src="assets/sfx/whoosh-short.mp3" data-start="{{T:52.4}}" data-duration="1.0" data-track-index="22" data-volume="0.25"></audio>
      <audio id="sfx35" src="assets/sfx/pop.mp3" data-start="{{T:53.6}}" data-duration="1.0" data-track-index="23" data-volume="0.35"></audio>
      <audio id="sfx36" src="assets/sfx/pop.mp3" data-start="{{T:54.15}}" data-duration="1.0" data-track-index="20" data-volume="0.35"></audio>
      <audio id="sfx37" src="assets/sfx/pop.mp3" data-start="{{T:54.7}}" data-duration="1.0" data-track-index="21" data-volume="0.35"></audio>
      <audio id="sfx38" src="assets/sfx/chime.mp3" data-start="{{T:56.0}}" data-duration="1.0" data-track-index="22" data-volume="0.3"></audio>
      <audio id="sfx39" src="assets/sfx/click.mp3" data-start="{{T:62.4}}" data-duration="1.0" data-track-index="23" data-volume="0.35"></audio>
      <audio id="sfx40" src="assets/sfx/sparkle.mp3" data-start="{{T:64.6}}" data-duration="1.0" data-track-index="20" data-volume="0.4"></audio>
      <audio id="sfx41" src="assets/sfx/chime.mp3" data-start="{{T:66.0}}" data-duration="1.0" data-track-index="21" data-volume="0.35"></audio>
      <audio id="sfx42" src="assets/sfx/glitch-2.mp3" data-start="{{T:68.0}}" data-duration="1.0" data-track-index="22" data-volume="0.55"></audio>
      <audio id="sfx43" src="assets/sfx/impact-bass-1.mp3" data-start="{{T:68.0}}" data-duration="1.0" data-track-index="23" data-volume="0.5"></audio>
      <audio id="sfx44" src="assets/sfx/whoosh-short.mp3" data-start="{{T:68.0}}" data-duration="1.0" data-track-index="20" data-volume="0.22"></audio>
      <audio id="sfx45" src="assets/sfx/whoosh-short.mp3" data-start="{{T:70.0}}" data-duration="1.0" data-track-index="21" data-volume="0.22"></audio>
      <audio id="sfx46" src="assets/sfx/riser.mp3" data-start="{{T:70.2}}" data-duration="1.6" data-track-index="22" data-volume="0.18"></audio>
      <audio id="sfx47" src="assets/sfx/whoosh-short.mp3" data-start="{{T:74.6}}" data-duration="1.0" data-track-index="23" data-volume="0.22"></audio>
      <audio id="sfx48" src="assets/sfx/whoosh.mp3" data-start="{{T:74.65}}" data-duration="1.0" data-track-index="20" data-volume="0.3"></audio>
      <audio id="sfx49" src="assets/sfx/whoosh-short.mp3" data-start="{{T:78.35}}" data-duration="1.0" data-track-index="21" data-volume="0.3"></audio>
      <audio id="sfx50" src="assets/sfx/ping.mp3" data-start="{{T:79.95}}" data-duration="1.0" data-track-index="22" data-volume="0.35"></audio>
    </div>

    <script>
      (function () {
        const KEEP = /*KEEP*/;
        const SPEED = 1.1;
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

        // ---------- generated content ----------
        const STEPS = ["Mutton 1 kg, washed", "Marinate 2 hrs", "Rice 70% cooked", "Layer + dum 25 min", "Same masala, same ratio"];
        $("#p4-steps").innerHTML = STEPS.map((s, i) => `<div class="p4-step" style="display:flex; align-items:center; gap:16px; font-family:PoppinsB; font-size:30px;"><span class="p4-tick" style="flex:none; width:46px; height:46px; border-radius:50%; border:3px solid rgba(20,17,15,0.18); display:grid; place-items:center; font-size:26px; color:#fff;">✓</span><span><span style="color:rgba(20,17,15,0.4);">${i + 1}.</span> ${s}</span></div>`).join("");
        $("#p4-week").innerHTML = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].map((d) => `<div class="p4-day solid" style="flex:1; border-radius:20px; display:flex; align-items:center; justify-content:space-between; padding:0 22px;"><span class="b" style="font-size:26px; color:rgba(20,17,15,0.55);">${d}</span><span style="font-size:36px;">🍛</span><span class="b" style="font-size:24px; color:var(--green);">same ✓</span></div>`).join("");
        const CODE = [
          '<span class="c">---</span>',
          '<span class="k">name:</span> <span class="s">sunday-poster</span>',
          '<span class="k">description:</span> <span class="s">Dolu Bolu weekly poster</span>',
          '<span class="c">---</span>',
          '<span class="n">1.</span> Biryani: <span class="s">Mutton</span> <span class="c"># not chicken!</span>',
          '<span class="n">2.</span> Offer: <span class="s">Buy 1 Get 1</span>, max <span class="n">50</span> plates',
          '<span class="n">3.</span> Price floor: <span class="n">₹180</span>',
          '<span class="n">4.</span> Style: <span class="s">saffron, bold, Tamil + English</span>',
          '<span class="n">5.</span> Size: <span class="s">A3</span>',
        ];
        $("#p5-code").innerHTML = CODE.map((l) => `<div class="p5-ln" style="display:block;">${l}</div>`).join("");
        $("#p5-outs").innerHTML = [0, 1, 2].map(() => `<div class="p5-out poster" style="width:190px; height:100px; flex-direction:row; gap:10px; border:2px solid var(--green);"><span class="xb" style="font-size:24px; color:var(--brown); line-height:1;">MUTTON<br />BIRYANI</span><span style="font-size:34px; color:var(--green);">✓</span></div>`).join("");
        let g = "";
        for (let i = 0; i < 52; i++) g += `<i class="p7-w" style="display:block; height:44px; border-radius:10px; background:#ece8e2;"></i>`;
        $("#p7-grid").innerHTML = g;
        const er = rng(4), EM = ["😂", "🤣", "💀", "😭", "🔥"];
        let em = "";
        for (let i = 0; i < 18; i++) em += `<span class="p3-e" style="position:absolute; left:${(80 + er() * 900).toFixed(0)}px; top:${(560 + er() * 200).toFixed(0)}px; font-size:${(54 + er() * 40).toFixed(0)}px;">${EM[i % 5]}</span>`;
        $("#p3-emoji").innerHTML = em;
        $("#o5-days").innerHTML = [1, 2, 3, 4, 5].map((i) => `<div class="o5-d" style="flex:1; height:110px; border-radius:24px; display:flex; flex-direction:column; align-items:center; justify-content:center; font-family:PoppinsXB; ${i <= 2 ? "background:linear-gradient(135deg,var(--saffron),var(--gold)); color:#fff;" : i === 3 ? "background:#fff; border:3px solid var(--ink);" : "background:rgba(20,17,15,0.06); color:rgba(20,17,15,0.35);"}"><span style="font-size:20px; letter-spacing:3px;">DAY</span><span style="font-size:42px; line-height:1;">${i <= 2 ? "✓" : i === 3 ? "3" : "🔒"}</span></div>`).join("");

        // ---------- layout plan (original seconds) ----------
        const LAYOUT = [[0, "F"], [6.2, "S"], [19.5, "F"], [22.66, "S"], [26.72, "F"], [35.5, "S"], [43.1, "F"], [47.0, "S"], [68.0, "F"], [70.0, "S"], [74.6, "F"]];
        const layoutAt = (t) => { let l = "F"; LAYOUT.forEach(([s, v]) => { if (t >= s - 0.001) l = v; }); return l; };

        // ---------- captions ----------
        // [start, end, "chunk|chunk|chunk", style]; time inside a phrase is shared by chunk length.
        // *x y* = key words, !x y! = red.
        const PHRASES = [
          [0.05, 2.46, "AI use pannumbodhu|adikkadi *MISTAKES*|!pannureengala?!", "hook"],
          [2.46, 3.86, "indha video|*ungalukku dhaan*", "hook"],
          [3.86, 5.2, "vaanga AI kathukalam|series-la inniki", "hook"],
          [6.2, 10.68, "last episode *loss*-kku appuram|namma *Dolu Bolu*|nalla oru *lesson* kathukittaanga", "base"],
          [10.68, 14.9, "ippo nalla *context*-oda|*detailed prompts*|mattum dhaan use panraanga", "base"],
          [14.9, 19.45, "oru naal|avasara avasarama|*enna biryani*-nu|mention panna !marandhaanga!", "base"],
          [19.52, 22.6, "kadaisila ChatGPT|*veg chicken biryani*|kuduthiruchu! 😭", "marker"],
          [22.66, 26.7, "adhukku appuram enna...|ella *memes*-layum|namma Dolu Bolu kadai dhaan 😂", "marker"],
          [26.72, 33.45, "sometimes evvalavu detail-aa|prompt kuduthaalum|oru *chinna vishayam* miss aana|expect panna result|*kidaikkaadhu*", "editorial"],
          [33.5, 34.3, "adhukku solution dhaan", "base"],
          [35.5, 40.4, "oru cook kitta|*recipe card* irukkum|enna samaikkanum|*eppadi* samaikkanum", "base"],
          [40.4, 43.05, "adha paathu|*daily* replicate pannuvaanga", "base"],
          [43.1, 47.0, "adhe concept dhaan|*skills* = *recipe card*", "terminal"],
          [47.0, 52.0, "namma kudukkura *steps*|namma kudukkura *instructions*|*exact*-ah follow panni", "base"],
          [52.0, 57.6, "expect panra result|*thirumba thirumba*|kidaikkum ✅", "base"],
          [58.8, 62.44, "ippo Dolu Bolu|*sunday special poster*-nu|sonna podhum", "base"],
          [62.44, 67.9, "skill-la irukkura instructions vechu|ChatGPT *clear*-aana poster|*ready* panni kudukkum", "base"],
          [68.0, 70.0, "but still...|oru *problem* irukku", "glitch"],
          [70.04, 74.55, "every *saturday evening*|or *sunday morning*|Dolu Bolu dhaan|poi ChatGPT-kitta kekkanum 😩", "base"],
          [74.62, 78.25, "indha problem-a|eppadi *overcome* panradhu?|*next episode*-la paakalaam", "base"],
          [78.3, 79.84, "until then|it's *Joshua Collins*", "base"],
          [79.84, 81.45, "let's build the|*leverage*|together 🚀", "base"],
        ];
        const CAPS = [];
        PHRASES.forEach(([a, b, txt, st]) => {
          const parts = txt.split("|"), w = parts.map((p) => p.replace(/[*!]/g, "").length + 6), tot = w.reduce((x, y) => x + y, 0);
          let t = a;
          parts.forEach((p, i) => { const d = ((b - a) * w[i]) / tot; CAPS.push([t, t + d, p, st]); t += d; });
        });
        const capRoot = $("#captions");
        CAPS.forEach((c, i) => {
          const d = document.createElement("div");
          d.className = "cap st-" + c[3] + " " + (layoutAt(c[0] + 0.05) === "S" ? "split" : "full");
          d.id = "cap" + i;
          const parts = c[2].match(/\*[^*]+\*[^ ]*|![^!]+!|[^ ]+/g) || [];
          d.innerHTML = parts.flatMap((p) => {
            if (p[0] === "*") return [`<span class="w k">${p.replace(/^\*([^*]+)\*/, "$1")}</span>`];
            if (p[0] === "!") return [`<span class="w r">${p.replace(/^!([^!]+)!/, "$1")}</span>`];
            return [`<span class="w">${p}</span>`];
          }).join("");
          capRoot.appendChild(d);
        });

        // ---------- timeline ----------
        const tl = gsap.timeline({ paused: true });
        const E = "expo.out";
        const count = (el, from, to, t, d, fmt = (v) => Math.round(v).toLocaleString("en-IN")) => {
          const o = { v: from };
          tl.fromTo(o, { v: from }, { v: to, duration: d, ease: "power3.out", onUpdate: () => { el.textContent = fmt(o.v); } }, t);
        };
        const enter = (el, t, o = {}) => tl.fromTo(el, { y: o.y ?? 60, opacity: 0, scale: o.s ?? 0.96, filter: "blur(14px)" }, { y: 0, opacity: 1, scale: 1, filter: "blur(0px)", duration: o.d ?? 0.7, ease: E, stagger: o.st ?? 0 }, t);
        const exit = (el, t, d = 0.35) => tl.to(el, { y: -40, opacity: 0, filter: "blur(10px)", duration: d, ease: "power2.in" }, t);
        const sweep = (el, t, w = 1300) => tl.fromTo(el, { x: 0 }, { x: w, duration: 0.9, ease: "power2.inOut" }, t);
        const flash = (t, a = 0.85) => tl.fromTo("#flash", { opacity: a }, { opacity: 0, duration: 0.35, ease: "power2.out", immediateRender: false }, t);

        // camera morph between full frame and the bottom card
        const FULL = { clip: "inset(0px 0px 0px 0px round 0px)", y: 0, s: 1 };
        const CARD = { clip: "inset(880px 44px 40px 44px round 44px)", y: 494, s: 0.92 };
        tl.set("#vclip", { clipPath: FULL.clip }, 0);
        tl.set("#vframe", { y: 0, scale: 1 }, 0);
        LAYOUT.forEach(([t0, l], i) => {
          if (i === 0) return;
          const s = l === "S" ? CARD : FULL, t = T(t0);
          tl.to("#vclip", { clipPath: s.clip, duration: 0.42, ease: "expo.inOut" }, t - 0.06);
          tl.to("#vframe", { y: s.y, scale: s.s, duration: 0.42, ease: "expo.inOut" }, t - 0.06);
        });

        // ---- HOOK: riser build-in, drop zoom-out, punch on "ungalukku dhaan", DAY 2 behind subject ----
        tl.fromTo("#vzoom", { scale: 1.0 }, { scale: 1.32, duration: 1.5, ease: "power2.in" }, 0);
        tl.to("#vzoom", { scale: 1.0, duration: 0.55, ease: "expo.out" }, 1.5);
        tl.fromTo("#vzoom", { x: -14 }, { x: 14, duration: 0.04, repeat: 7, yoyo: true, ease: "none" }, 1.5);
        tl.set("#vzoom", { x: 0 }, 1.82);
        tl.fromTo("#vzoom", { filter: "blur(0px)" }, { filter: "blur(10px)", duration: 0.12, yoyo: true, repeat: 1, ease: "power2.out" }, 1.44);
        flash(1.5, 0.9);
        tl.to("#vzoom", { scale: 1.14, duration: 0.18, ease: "power3.out" }, T(2.5));
        tl.to("#vzoom", { scale: 1.0, duration: 0.6, ease: "expo.out" }, T(3.5));
        tl.set("#behind", { opacity: 0 }, 0);
        tl.set("#behind", { opacity: 1 }, T(3.86));
        tl.fromTo("#beh-pill", { y: -60, opacity: 0 }, { y: 0, opacity: 1, duration: 0.5, ease: E }, T(3.9));
        tl.fromTo("#beh-day", { scale: 1.6, opacity: 0, filter: "blur(20px)" }, { scale: 1, opacity: 1, filter: "blur(0px)", duration: 0.7, ease: E }, T(4.9));
        tl.to("#behind", { opacity: 0, duration: 0.25 }, T(5.55));
        tl.set("#matte", { opacity: 0 }, T(5.55) + 0.25);
        // later jump cuts: alternate a gentle reframe so cuts read as intentional
        let acc = 0;
        KEEP.forEach(([s, e], k) => {
          const t = acc / SPEED;
          if (t > 6.2) tl.set("#vzoom", { scale: k % 2 ? 1.06 : 1.0 }, t);
          acc += e - s;
        });
        // But-still glitch punch
        tl.set("#vzoom", { scale: 1.18 }, T(68.0));
        tl.to("#vzoom", { scale: 1.04, duration: 0.6, ease: "expo.out" }, T(68.0) + 0.05);
        tl.fromTo("#rgb", { opacity: 1 }, { opacity: 0, duration: 0.35, ease: "steps(4)", immediateRender: false }, T(68.0));
        tl.fromTo("#vzoom", { x: -18 }, { x: 18, duration: 0.03, repeat: 7, yoyo: true, ease: "none" }, T(68.0));
        tl.set("#vzoom", { x: 0 }, T(68.0) + 0.25);

        // ---- captions by style ----
        CAPS.forEach((c, i) => {
          const el = $("#cap" + i), ws = el.querySelectorAll(".w"), t0 = T(c[0]), t1 = T(c[1]);
          const st = Math.min(0.06, ((t1 - t0) * 0.3) / Math.max(1, ws.length));
          tl.set(el, { opacity: 1 }, t0);
          if (c[3] === "editorial") {
            tl.fromTo(ws, { y: 24, opacity: 0, filter: "blur(10px)" }, { y: 0, opacity: 1, filter: "blur(0px)", duration: 0.55, ease: "power3.out", stagger: st * 1.4 }, t0);
          } else if (c[3] === "marker") {
            tl.fromTo(ws, { scale: 1.6, rotation: -8, opacity: 0 }, { scale: 1, rotation: (k) => (k % 2 ? 2 : -3), opacity: 1, duration: 0.22, ease: "back.out(3)", stagger: st }, t0);
          } else if (c[3] === "terminal") {
            const CH = "ABCDEF0123456789#$%&@<>/";
            ws.forEach((w, k) => {
              const final = w.textContent;
              for (let f = 0; f <= 8; f++) tl.call(() => { w.textContent = f === 8 ? final : final.split("").map((ch, j) => (ch === " " ? " " : j < (f / 8) * final.length ? ch : CH[(j * 7 + f * 3 + k) % CH.length])).join(""); }, null, t0 + k * 0.08 + f * 0.035);
            });
            tl.fromTo(el, { opacity: 0, scale: 0.94 }, { opacity: 1, scale: 1, duration: 0.3, ease: E }, t0);
          } else if (c[3] === "glitch") {
            tl.fromTo(ws, { x: -30, opacity: 0, skewX: -20 }, { x: 0, opacity: 1, skewX: 0, duration: 0.18, ease: "steps(3)", stagger: 0.05 }, t0);
            tl.fromTo(el, { x: -10 }, { x: 10, duration: 0.03, repeat: 5, yoyo: true, ease: "none" }, t0 + 0.05);
            tl.set(el, { x: 0 }, t0 + 0.25);
          } else {
            tl.fromTo(ws, { y: 30, scale: 0.7, opacity: 0, filter: "blur(3px)" }, { y: 0, scale: 1, opacity: 1, filter: "blur(0px)", duration: 0.2, ease: "back.out(2.2)", stagger: st }, t0);
          }
          tl.set(el, { opacity: 0 }, t1);
        });

        // ---- P1 recap ----
        enter("#p1-card", T(6.2));
        tl.fromTo("#p1-poster", { rotation: -10, scale: 0.8, opacity: 0 }, { rotation: -4, scale: 1, opacity: 1, duration: 0.6, ease: E }, T(6.5));
        tl.fromTo("#p1-loss", { scale: 2.4, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.3, ease: "power4.in" }, T(7.2));
        tl.fromTo("#p1-twins", { x: 120, opacity: 0 }, { x: 0, opacity: 1, duration: 0.7, ease: E }, T(8.3));
        tl.fromTo("#p1-twins", { y: 0 }, { y: -12, duration: 0.45, yoyo: true, repeat: 5, ease: "sine.inOut" }, T(9.1));
        tl.fromTo(".p1-row", { x: -40, opacity: 0 }, { x: 0, opacity: 1, duration: 0.5, ease: E, stagger: 0.5 }, T(10.8));
        tl.fromTo(".p1-tick", { scale: 0 }, { scale: 1, duration: 0.45, ease: "back.out(3)", stagger: 0.5 }, T(10.9));

        // ---- P2 hurried prompt ----
        enter("#p2-card", T(14.9));
        tl.fromTo(".p2-l", { opacity: 0, x: -30 }, { opacity: 1, x: 0, duration: 0.35, ease: E, stagger: 0.28 }, T(15.2));
        tl.fromTo("#p2-hurry", { scale: 1 }, { scale: 1.08, duration: 0.15, yoyo: true, repeat: 5 }, T(15.6));
        tl.fromTo("#p2-slot", { backgroundColor: "rgba(224,38,26,0)" }, { backgroundColor: "rgba(224,38,26,0.15)", duration: 0.22, yoyo: true, repeat: 7, ease: "steps(1)" }, T(17.4));
        tl.fromTo("#p2-warn", { scale: 0.4, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.45, ease: "back.out(2.4)" }, T(17.6));
        tl.fromTo("#p2-send", { scale: 1 }, { scale: 0.9, duration: 0.1, yoyo: true, repeat: 1 }, T(18.6));
        tl.to("#p2-card", { x: 1200, rotation: 8, duration: 0.5, ease: "power3.in" }, T(18.8));

        // ---- O1 veg chicken biryani ----
        tl.fromTo("#o1-poster", { y: -600, rotation: 10 }, { y: 0, rotation: -3, duration: 0.7, ease: "back.out(1.3)" }, T(19.6));
        tl.fromTo("#o1-circle path", { strokeDasharray: 1800, strokeDashoffset: 1800 }, { strokeDashoffset: 0, duration: 0.6, ease: "power2.inOut" }, T(20.8));
        tl.fromTo("#o1-q", { scale: 0, rotation: -30 }, { scale: 1, rotation: 8, duration: 0.4, ease: "back.out(3)" }, T(21.2));

        // ---- P3 memes ----
        tl.fromTo(".p3-m", { y: 400, opacity: 0, scale: 0.8 }, { y: 0, opacity: 1, scale: 1, duration: 0.6, ease: "back.out(1.5)", stagger: 0.35 }, T(22.7));
        enter("#p3-trend", T(23.6), { y: -30 });
        $$(".p3-like").forEach((el, i) => count(el, 0, [12400, 8600, 23100][i], T(23.0) + i * 0.35, 2.4, (v) => (v >= 1000 ? (v / 1000).toFixed(1) + "K" : Math.round(v) + "")));
        tl.fromTo(".p3-e", { y: 80, opacity: 0, scale: 0.4 }, { y: -120, opacity: 1, scale: 1.1, duration: 0.7, ease: "back.out(2)", stagger: { each: 0.08, from: "random" } }, T(24.2));
        tl.to(".p3-e", { y: -260, opacity: 0, duration: 0.5, ease: "power1.in", stagger: { each: 0.05, from: "random" } }, T(24.2) + 1.5);

        // ---- O2 detail vs result ----
        enter("#o2-card", T(26.75));
        tl.fromTo("#o2-bar", { scaleX: 0 }, { scaleX: 0.98, duration: 2.2, ease: "power2.out" }, T(26.9));
        count($("#o2-pct"), 0, 98, T(26.9), 2.2);
        tl.fromTo("#o2-res", { scale: 0.4, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.5, ease: "back.out(2.4)" }, T(31.0));

        // ---- O3 SKILLS stomp ----
        tl.fromTo("#o3-bg", { opacity: 0 }, { opacity: 1, duration: 0.08 }, T(34.3));
        tl.fromTo("#o3-word", { scale: 2.6, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.22, ease: "power4.in" }, T(34.42));
        tl.fromTo("#o3-echo", { scale: 1, opacity: 0.9 }, { scale: 1.35, opacity: 0, duration: 0.7, ease: "power2.out" }, T(34.62));
        tl.fromTo("#o3-sub", { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.4, ease: E }, T(34.7));
        flash(T(34.62), 0.5);

        // ---- P4 recipe ----
        enter("#p4-card", T(35.5));
        tl.fromTo(".p4-step", { opacity: 0, x: -30 }, { opacity: 1, x: 0, duration: 0.4, ease: E, stagger: 0.3 }, T(36.0));
        tl.to(".p4-tick", { backgroundColor: "#19c37d", borderColor: "#19c37d", duration: 0.2, stagger: 0.4 }, T(37.4));
        tl.fromTo(".p4-day", { x: 80, opacity: 0 }, { x: 0, opacity: 1, duration: 0.45, ease: E, stagger: 0.18 }, T(40.4));

        // ---- O4 const skill = "recipe card" ----
        enter("#o4-card", T(43.1));
        const val = $("#o4-val"), V = '"recipe card"';
        tl.call(() => { val.textContent = ""; }, null, T(43.1));
        for (let i = 0; i <= V.length; i++) tl.call(() => { val.textContent = V.substring(0, i); }, null, T(43.5) + i * 0.06);
        tl.fromTo("#o4-caret", { opacity: 1 }, { opacity: 0, duration: 0.25, repeat: 11, yoyo: true, ease: "steps(1)" }, T(43.2));

        // ---- P5 SKILL.md, then flow ----
        enter("#p5-ed", T(47.0));
        tl.fromTo(".p5-ln", { opacity: 0, x: -20 }, { opacity: 1, x: 0, duration: 0.3, ease: E, stagger: 0.42 }, T(47.4));
        tl.to("#p5-ed", { opacity: 0, scale: 0.92, filter: "blur(12px)", duration: 0.4, ease: "power2.in" }, T(51.8));
        tl.set("#p5-flow", { opacity: 0 }, T(47.0));
        tl.to("#p5-flow", { opacity: 1, duration: 0.3 }, T(52.1));
        tl.fromTo("#p5-flow > *", { y: 40, opacity: 0, scale: 0.9 }, { y: 0, opacity: 1, scale: 1, duration: 0.5, ease: E, stagger: 0.18 }, T(52.1));
        tl.fromTo(".p5-arr", { strokeDasharray: 160, strokeDashoffset: 160 }, { strokeDashoffset: 0, duration: 0.5, stagger: 0.4 }, T(52.4));
        tl.fromTo(".p5-out", { x: -60, opacity: 0 }, { x: 0, opacity: 1, duration: 0.45, ease: "back.out(2)", stagger: 0.55 }, T(53.6));

        // ---- P6 poster from one line ----
        enter("#p6-chat", T(58.8));
        tl.fromTo("#p6-using", { scale: 0.5, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.45, ease: "back.out(2.4)" }, T(62.4));
        tl.fromTo("#p6-poster", { scale: 0.5, rotationY: -35, transformPerspective: 1600, opacity: 0, filter: "blur(16px)" }, { scale: 1, rotationY: 0, opacity: 1, filter: "blur(0px)", duration: 0.8, ease: E }, T(64.6));
        sweep("#p6-sweep", T(65.4), 900);
        tl.fromTo("#p6-ok", { scale: 0, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.45, ease: "back.out(3)" }, T(66.0));

        // ---- P7 every weekend ----
        tl.fromTo(".p7-w", { scale: 0.6 }, { scale: 1, backgroundColor: "#ff9933", duration: 0.2, ease: "back.out(2)", stagger: 0.035 }, T(70.2));
        count($("#p7-num"), 0, 52, T(70.2), 2.0);
        tl.fromTo("#p7-hand", { rotation: 0 }, { rotation: 1080, duration: T(74.6) - T(70.0), ease: "none" }, T(70.0));

        // ---- O5 tease, O6 name, O7 follow ----
        enter("#o5-card", T(74.65));
        tl.fromTo(".o5-d", { y: 30, opacity: 0 }, { y: 0, opacity: 1, duration: 0.45, ease: E, stagger: 0.07 }, T(74.8));
        tl.fromTo("#o5-next", { filter: "blur(14px)" }, { filter: "blur(7px)", duration: 1.5, yoyo: true, repeat: 1, ease: "sine.inOut" }, T(76.0));
        tl.fromTo("#o6-card", { x: -600, opacity: 0, filter: "blur(10px)" }, { x: 0, opacity: 1, filter: "blur(0px)", duration: 0.7, ease: E }, T(78.35));
        enter("#o7-btns", T(79.95));
        tl.fromTo("#o7-f", { scale: 1 }, { scale: 1.07, duration: 0.3, yoyo: true, repeat: 3, ease: "sine.inOut" }, T(80.4));

        window.__timelines["main"] = tl;
      })();
    </script>
  </body>
</html>
