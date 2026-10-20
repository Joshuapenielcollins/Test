<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Dolu Bolu Reel</title>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.14.2/dist/gsap.min.js"></script>
    <style>
      @font-face { font-family: "PoppinsXB"; src: url("assets/fonts/Poppins-ExtraBold.ttf") format("truetype"); font-weight: 800; }
      @font-face { font-family: "PoppinsB"; src: url("assets/fonts/Poppins-Bold.ttf") format("truetype"); font-weight: 700; }
      @font-face { font-family: "PoppinsSB"; src: url("assets/fonts/Poppins-SemiBold.ttf") format("truetype"); font-weight: 600; }
      @font-face { font-family: "MontserratV"; src: url("assets/fonts/Montserrat-VF.ttf") format("truetype"); font-weight: 100 900; }
      @font-face { font-family: "PoppinsM"; src: url("assets/fonts/Poppins-Medium.ttf") format("truetype"); font-weight: 500; }
      :root {
        --saffron: #ff9933; --gold: #ffb627; --brown: #3b1f0e; --ink: #14110f; --paper: #f4f1ec;
        --red: #ff3b30; --green: #19c37d; --blue: #2d7bff; --violet: #7c5cff; --cyan: #29d3ff;
        --glass: rgba(255,255,255,0.72); --line: rgba(20,17,15,0.08);
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

      /* paper stage: grid + warm vignette */
      #paper { z-index: 0; background:
          radial-gradient(120% 70% at 50% 20%, rgba(255,182,39,0.10), transparent 60%),
          linear-gradient(var(--line) 1.5px, transparent 1.5px) 0 0 / 60px 60px,
          linear-gradient(90deg, var(--line) 1.5px, transparent 1.5px) 0 0 / 60px 60px,
          var(--paper); }

      /* camera: clip box > layout transform > micro zoom > video */
      #vclip { position: absolute; inset: 0; z-index: 2; overflow: hidden; }
      #vframe { position: absolute; inset: 0; transform-origin: 50% 0%; }
      #vzoom { position: absolute; inset: 0; transform-origin: 50% 35%; }
      #talk { position: absolute; inset: 0; width: 100%; height: 100%; object-fit: cover; filter: contrast(1.05) saturate(1.06); }
      #vgrade { position: absolute; inset: 0; background: radial-gradient(110% 80% at 50% 35%, transparent 55%, rgba(10,6,2,0.38) 100%), linear-gradient(180deg, transparent 58%, rgba(10,6,2,0.45) 100%); }
      #vring { position: absolute; inset: 0; z-index: 2; pointer-events: none; border-radius: 44px; box-shadow: inset 0 0 0 2px rgba(255,255,255,0.5); opacity: 0; }

      /* top panels (split layout) */
      .panel { position: absolute; left: 0; right: 0; top: 0; height: 790px; z-index: 3; overflow: hidden; }
      .pz { position: absolute; inset: 0; transform: scale(0.9); transform-origin: 50% 0%; }
      .overlay { position: absolute; left: 0; right: 0; top: 0; height: 900px; z-index: 3; }
      .glass { background: var(--glass); border: 1.5px solid rgba(255,255,255,0.9); border-radius: 36px; box-shadow: var(--shadow); }
      .solid { background: #fff; border: 1.5px solid rgba(20,17,15,0.06); border-radius: 36px; box-shadow: var(--shadow); }
      .eyebrow { font-family: "PoppinsB"; font-size: 24px; letter-spacing: 5px; text-transform: uppercase; color: rgba(20,17,15,0.5); }
      .chip { display: inline-flex; align-items: center; gap: 12px; padding: 12px 24px; border-radius: 999px; font-family: "PoppinsB"; font-size: 28px; }
      .mask { overflow: hidden; display: block; padding-bottom: 0.06em; }
      .mask > span { display: inline-block; }
      .sweep { position: absolute; top: -20%; bottom: -20%; width: 160px; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.75), transparent); transform: skewX(-18deg); pointer-events: none; }
      .tech { background: linear-gradient(160deg, #141a3a 0%, #0b0e22 100%); border: 1.5px solid rgba(124,92,255,0.45); border-radius: 36px; box-shadow: 0 30px 80px rgba(20,20,60,0.35), inset 0 1px 0 rgba(255,255,255,0.08); }
      .phone { position: absolute; width: 470px; height: 780px; border-radius: 70px; background: #0d0f1c; padding: 14px; box-shadow: 0 2px 0 #3a3d4d inset, 0 40px 90px rgba(20,17,15,0.35), 0 0 0 3px #2a2c38; }
      .phone .scr { position: absolute; inset: 14px; border-radius: 56px; background: linear-gradient(180deg, #f7f8fc, #eef0f7); overflow: hidden; padding: 110px 26px 26px; display: flex; flex-direction: column; gap: 18px; }
      .phone .island { position: absolute; left: 50%; top: 30px; width: 130px; height: 38px; margin-left: -65px; border-radius: 20px; background: #0d0f1c; z-index: 2; }
      .phone .hdr { position: absolute; left: 0; right: 0; top: 0; height: 96px; display: flex; align-items: flex-end; justify-content: center; padding-bottom: 12px; font-family: "PoppinsB"; font-size: 24px; color: #1b1e2e; border-bottom: 1px solid rgba(0,0,0,0.06); background: rgba(255,255,255,0.8); }
      .bub { max-width: 88%; padding: 18px 24px; border-radius: 26px; font-family: "PoppinsSB"; font-size: 27px; line-height: 1.3; }
      .bub.me { align-self: flex-end; background: linear-gradient(135deg, var(--blue), var(--violet)); color: #fff; border-bottom-right-radius: 8px; }
      .bub.ai { align-self: flex-start; background: #fff; color: #1b1e2e; border-bottom-left-radius: 8px; box-shadow: 0 6px 16px rgba(0,0,0,0.06); }
      .tok { display: flex; align-items: center; gap: 20px; }
      .tok .lb { width: 250px; text-align: right; font-family: "PoppinsXB"; font-size: 44px; }
      .tok .tr { width: 470px; height: 30px; border-radius: 15px; background: rgba(20,17,15,0.07); overflow: hidden; }
      .tok .fl { display: block; height: 100%; border-radius: 15px; transform-origin: 0 50%; }
      .tok .pc { font-family: "PoppinsB"; font-size: 32px; color: rgba(20,17,15,0.55); width: 90px; }

      /* captions: script style (white, black stroke, saffron key words), word-by-word pop */
      #captions { z-index: 6; pointer-events: none; }
      .cap { position: absolute; left: 40px; right: 40px; display: flex; flex-wrap: wrap; justify-content: center; align-items: center; gap: 10px 18px; opacity: 0; text-align: center; }
      .cap.full { top: 1370px; }
      .cap.split { top: 772px; }
      .cap .w { display: inline-block; font-family: "MontserratV"; font-weight: 900; text-transform: uppercase; letter-spacing: -1px; font-size: 76px; line-height: 1.08; color: #fff; paint-order: stroke fill; -webkit-text-stroke: 12px #0b0806; text-shadow: 0 10px 28px rgba(0,0,0,0.4); transform-origin: 50% 85%; }
      .cap.split .w { font-size: 62px; -webkit-text-stroke: 10px #0b0806; }
      .cap .w.k, .cap .w.r { -webkit-text-stroke: 0; padding: 4px 22px 8px; border-radius: 16px; text-shadow: none; box-shadow: 0 12px 30px rgba(0,0,0,0.35), inset 0 -4px 0 rgba(0,0,0,0.12); }
      .cap .w.k { color: #1a1206; background: linear-gradient(180deg, #ffc93c, #ff9f1c); }
      .cap .w.r { color: #fff; background: linear-gradient(180deg, #ff5a4f, #e0261a); }
      .cap.big .w { font-size: 104px; }
      .cap.split.big .w { font-size: 78px; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="main" data-start="0" data-width="1080" data-height="1920" data-duration="{{T:92.2}}">
      <div id="paper" class="clip"></div>

      <div id="vclip">
        <div id="vframe"><div id="vzoom">
          <video id="talk" src="assets/media/talk-cut.mp4" muted playsinline data-start="0" data-duration="{{T:92.2}}" data-track-index="0"></video>
          <div id="vgrade"></div>
        </div></div>
      </div>

      <!-- ================= SPLIT PANELS ================= -->

      <!-- 200 people: dot-matrix data viz -->
      <section id="p1" class="panel clip" data-start="{{T:2.4}}" data-duration="{{D:2.4:5.1}}" data-track-index="2"><div class="pz">
        <div class="abs solid" id="p1-card" style="left:60px; right:60px; top:70px; height:700px; padding:46px 54px;">
          <div class="abs" style="right:34px; top:18px; height:150px;"><img src="assets/twins.png" alt="Dolu and Bolu" style="display:block; height:100%; width:auto; filter:drop-shadow(0 14px 22px rgba(20,17,15,0.22));" /></div>
          <div class="eyebrow">Outside Dolu Bolu Biryani Kadai</div>
          <div style="display:flex; align-items:baseline; gap:18px; margin-top:6px;"><span class="xb" id="p1-num" style="font-size:150px; line-height:1; letter-spacing:-4px;">0</span><span class="b" style="font-size:44px; color:rgba(20,17,15,0.55);">people waiting</span></div>
          <div id="p1-grid" style="display:grid; grid-template-columns:repeat(20, 1fr); gap:10px; margin-top:34px;"></div>
        </div>
      </div></section>

      <!-- Series intro -->
      <section id="p2" class="panel clip" data-start="{{T:8.2}}" data-duration="{{D:8.2:11.0}}" data-track-index="2"><div class="pz">
        <div class="abs tech" id="p2-card" style="left:60px; right:60px; top:70px; height:700px; padding:56px 60px; overflow:hidden;">
          <div class="abs" style="right:-120px; top:-160px; width:520px; height:520px; border-radius:50%; background:radial-gradient(circle, rgba(124,92,255,0.55), transparent 65%);"></div>
          <div class="eyebrow" style="color:rgba(255,255,255,0.55);">5-day series</div>
          <div class="mask xb" style="font-size:118px; line-height:1.05; color:#fff; margin-top:10px;"><span id="p2-t1">Vanga AI</span></div>
          <div class="mask xb" style="font-size:118px; line-height:1.05; margin-top:-6px;"><span id="p2-t2" style="background:linear-gradient(90deg,var(--cyan),var(--violet)); -webkit-background-clip:text; background-clip:text; color:transparent;">Kathukalam</span></div>
          <div class="abs" style="left:60px; right:60px; top:470px; height:120px;">
            <div class="abs" style="left:40px; right:40px; top:38px; height:6px; border-radius:3px; background:rgba(255,255,255,0.12);"></div>
            <div class="abs" id="p2-prog" style="left:40px; width:100%; max-width:calc(100% - 80px); top:38px; height:6px; border-radius:3px; background:linear-gradient(90deg,var(--cyan),var(--violet)); transform-origin:0 50%;"></div>
            <div id="p2-days" class="abs" style="left:0; right:0; top:0; display:flex; justify-content:space-between;"></div>
          </div>
        </div>
      </div></section>

      <!-- Dolu Bolu profile, then the AI chat on a phone -->
      <section id="p3" class="panel clip" data-start="{{T:11.0}}" data-duration="{{D:11.0:19.4}}" data-track-index="2"><div class="pz">
        <div class="abs solid" id="p3-profile" style="left:110px; right:110px; top:150px; height:480px; padding:50px; display:flex; flex-direction:column; align-items:center; text-align:center;">
          <div style="height:230px;"><img src="assets/twins.png" alt="Dolu and Bolu" style="display:block; height:100%; width:auto; filter:drop-shadow(0 14px 22px rgba(20,17,15,0.22));" /></div>
          <div class="xb" style="font-size:64px; margin-top:14px; line-height:1;">Dolu Bolu</div>
          <div class="m" style="font-size:30px; color:rgba(20,17,15,0.55); margin-top:10px;">Twin owners · Dolu Bolu Biryani Kadai</div>
          <div style="display:flex; gap:14px; margin-top:24px;"><span class="chip" style="background:#fff3df; color:#a8560c;">🔥 Weekend rush</span><span class="chip" style="background:#eef3ff; color:#2d5bd8;">Needs a poster</span></div>
        </div>
        <div class="phone" id="p3-phone" style="left:305px; top:60px;">
          <div class="island"></div>
          <div class="scr">
            <div class="hdr">AI Assistant</div>
            <div class="bub me" id="p3-msg"><span id="p3-typed"></span><span id="p3-caret" style="display:inline-block; width:3px; height:30px; background:#fff; vertical-align:middle; margin-left:2px;"></span></div>
            <div class="bub ai" id="p3-think" style="display:flex; gap:10px; padding:22px 26px;"><i style="width:14px;height:14px;border-radius:50%;background:#9aa3c7;display:block"></i><i style="width:14px;height:14px;border-radius:50%;background:#9aa3c7;display:block"></i><i style="width:14px;height:14px;border-radius:50%;background:#9aa3c7;display:block"></i></div>
          </div>
        </div>
      </div></section>

      <!-- BUY 1 GET 1 FREE hero -->
      <section id="p4" class="panel clip" data-start="{{T:21.3}}" data-duration="{{D:21.3:23.6}}" data-track-index="2"><div class="pz">
        <svg class="abs" viewBox="-540 -420 1080 840" style="left:0; top:0; width:1080px; height:840px;"><g id="p4-rays"></g></svg>
        <div id="p4-conf" class="abs" style="left:0; top:0; width:1080px; height:840px;"></div>
        <div class="abs" id="p4-poster" style="left:250px; top:70px; width:580px; height:700px; border-radius:28px; background:linear-gradient(160deg,#fffaf0,#ffe9c7); box-shadow:var(--shadow); overflow:hidden; display:flex; flex-direction:column; align-items:center; justify-content:center; border:1.5px solid rgba(255,255,255,0.9);">
          <div class="eyebrow" style="color:#a8560c;">Dolu Bolu Biryani · Weekend</div>
          <div class="xb" style="font-size:150px; line-height:0.95; color:var(--brown); margin-top:18px;">BUY 1</div>
          <div class="xb" style="font-size:150px; line-height:0.95; color:var(--saffron);">GET 1</div>
          <div class="xb" style="font-size:168px; line-height:0.95; background:linear-gradient(180deg,#ff5a3d,#e0261a); -webkit-background-clip:text; background-clip:text; color:transparent;">FREE!</div>
          <div class="sweep" id="p4-sweep" style="left:-200px;"></div>
        </div>
      </div></section>

      <!-- Sunday rush, then the twins check the day -->
      <section id="p5" class="panel clip" data-start="{{T:28.8}}" data-duration="{{D:28.8:34.6}}" data-track-index="2"><div class="pz">
        <div class="abs solid" id="p5-cal" style="left:90px; top:110px; width:330px; height:360px; overflow:hidden; transform-origin:50% 0%;">
          <div style="height:96px; background:linear-gradient(180deg,#ff5a4f,#e0261a); display:flex; align-items:center; justify-content:center;" class="b"><span style="color:#fff; font-size:30px; letter-spacing:6px;">WEEKEND</span></div>
          <div class="xb" style="font-size:66px; text-align:center; margin-top:40px;">SUNDAY</div>
          <div class="m" style="font-size:28px; text-align:center; color:rgba(20,17,15,0.5);">Offer day</div>
        </div>
        <div class="abs solid" id="p5-stat" style="left:460px; right:90px; top:110px; height:360px; padding:40px;">
          <div class="eyebrow">Orders</div>
          <div class="xb" style="font-size:120px; line-height:1.05;"><span id="p5-num">0</span></div>
          <div class="chip" style="background:#fff3df; color:#a8560c; margin-top:6px;">every order × 2</div>
        </div>
        <div id="p5-x2" class="abs" style="left:90px; right:90px; top:510px; height:240px; display:flex; flex-wrap:wrap; gap:14px; align-content:flex-start;"></div>
        <div class="abs solid" id="p5-bolu" style="left:90px; right:90px; top:150px; height:520px; padding:50px; display:flex; gap:44px; align-items:center;">
          <div style="height:300px; flex:none;"><img src="assets/twins.png" alt="Dolu and Bolu" style="display:block; height:100%; width:auto; filter:drop-shadow(0 14px 22px rgba(20,17,15,0.22));" /></div>
          <div>
            <div class="eyebrow">Sunday night</div>
            <div class="xb" style="font-size:72px; line-height:1.05;">Dolu Bolu</div>
            <div class="m" style="font-size:32px; color:rgba(20,17,15,0.6); margin-top:10px; line-height:1.35;">Sitting down to count the day’s sales…</div>
          </div>
        </div>
      </div></section>

      <!-- LLM explainer -->
      <section id="p6" class="panel clip" data-start="{{T:40.4}}" data-duration="{{D:40.4:48.6}}" data-track-index="2"><div class="pz">
        <div class="abs tech" style="left:60px; right:60px; top:70px; height:700px; overflow:hidden;">
          <div class="abs" style="left:-160px; bottom:-220px; width:640px; height:640px; border-radius:50%; background:radial-gradient(circle, rgba(41,211,255,0.35), transparent 65%);"></div>
          <div class="abs" id="p6-intro" style="left:0; right:0; top:170px; display:flex; flex-direction:column; align-items:center; gap:22px;">
            <div style="display:flex; align-items:center; gap:22px;"><div style="width:96px; height:96px; border-radius:26px; background:linear-gradient(135deg,var(--cyan),var(--violet)); box-shadow:0 0 50px rgba(124,92,255,0.7);"></div><span class="xb" style="font-size:104px; color:#fff;">ChatGPT</span></div>
            <div class="b" style="font-size:44px; color:#cfd6ff;">pinnaadi enna irukku?</div>
          </div>
          <div class="abs" id="p6-letters" style="left:0; right:0; top:90px; display:flex; justify-content:center; gap:10px;">
            <div class="xb" style="font-size:230px; line-height:1; color:#fff;"><span class="p6-l">L</span><span class="p6-l">L</span><span class="p6-l" style="background:linear-gradient(90deg,var(--cyan),var(--violet)); -webkit-background-clip:text; background-clip:text; color:transparent;">M</span></div>
          </div>
          <div class="abs" id="p6-words" style="left:0; right:0; top:370px; display:flex; justify-content:center; gap:22px; font-family:PoppinsXB; font-size:58px; color:#cfd6ff;"><span>Large</span><span style="color:#fff;">Language</span><span>Model</span></div>
          <svg class="abs" id="p6-net" viewBox="0 0 960 700" style="left:0; top:0; width:960px; height:700px;"></svg>
          <div id="p6-docs" class="abs" style="left:0; top:0; width:960px; height:700px;"></div>
          <div class="abs" id="p6-count" style="left:50px; bottom:44px;"><div class="eyebrow" style="color:rgba(255,255,255,0.5);">Trained on</div><div class="xb" style="font-size:66px; color:#fff;"><span id="p6-num">0</span>+ pages</div></div>
        </div>
      </div></section>

      <!-- Next-word prediction -->
      <section id="p7" class="panel clip" data-start="{{T:51.0}}" data-duration="{{D:51.0:56.2}}" data-track-index="2"><div class="pz">
        <div class="abs solid" style="left:60px; right:60px; top:70px; height:700px; padding:54px 50px;">
          <div class="eyebrow">Next-word prediction</div>
          <div class="xb" style="font-size:80px; margin-top:16px; white-space:nowrap;">Buy 1 Get <span id="p7-slot" style="display:inline-block; position:relative; min-width:250px; border-bottom:8px solid var(--ink);"><span id="p7-fill" style="display:inline-block; background:linear-gradient(135deg,var(--blue),var(--violet)); color:#fff; padding:0 16px; border-radius:14px;">1 Free</span></span></div>
          <div id="p7-toks" style="display:flex; flex-direction:column; gap:26px; margin-top:52px;">
            <div class="tok" id="p7-t1"><span class="lb">1 Free</span><span class="tr"><span class="fl" style="width:87%; background:linear-gradient(90deg,var(--blue),var(--violet));"></span></span><span class="pc">87%</span></div>
            <div class="tok" id="p7-t2"><span class="lb">Discount</span><span class="tr"><span class="fl" style="width:9%; background:#b9b4ad;"></span></span><span class="pc">9%</span></div>
            <div class="tok" id="p7-t3"><span class="lb">Later</span><span class="tr"><span class="fl" style="width:4%; background:#b9b4ad;"></span></span><span class="pc">4%</span></div>
          </div>
          <div class="abs" id="p7-kb" style="left:50px; right:50px; bottom:44px; height:110px; border-radius:26px; background:#e9e6e1; display:flex; align-items:center; justify-content:space-around; font-family:PoppinsSB; font-size:38px; color:#3a352f;"><span>Free</span><span style="width:2px; height:50px; background:rgba(0,0,0,0.12);"></span><span style="color:var(--blue);">Offer</span><span style="width:2px; height:50px; background:rgba(0,0,0,0.12);"></span><span>Today</span></div>
        </div>
      </div></section>

      <!-- Missing info: the AI never knew the numbers -->
      <section id="p8" class="panel clip" data-start="{{T:58.4}}" data-duration="{{D:58.4:66.6}}" data-track-index="2"><div class="pz">
        <div class="abs solid" id="p8-rcpt" style="left:90px; width:520px; top:90px; height:660px; padding:44px 44px;">
          <div class="eyebrow">Cost per plate</div>
          <div id="p8-rows" style="margin-top:22px; display:flex; flex-direction:column; gap:20px; font-size:36px;">
            <div style="display:flex; justify-content:space-between;"><span class="m">Rice</span><span class="b">₹ ?</span></div>
            <div style="display:flex; justify-content:space-between;"><span class="m">Chicken</span><span class="b">₹ ?</span></div>
            <div style="display:flex; justify-content:space-between;"><span class="m">Gas</span><span class="b">₹ ?</span></div>
            <div style="display:flex; justify-content:space-between;"><span class="m">Staff</span><span class="b">₹ ?</span></div>
          </div>
          <div style="height:2px; background:rgba(20,17,15,0.1); margin:28px 0;"></div>
          <div class="b" style="font-size:34px;">Profit margin</div>
          <div id="p8-skel" style="margin-top:14px; height:64px; border-radius:16px; background:#ece8e2; position:relative; overflow:hidden;"><div class="sweep" id="p8-shim" style="left:-200px; width:200px;"></div></div>
        </div>
        <div class="abs tech" id="p8-ai" style="left:650px; right:90px; top:90px; height:660px; display:flex; flex-direction:column; align-items:center; justify-content:center; gap:20px;">
          <div class="xb" id="p8-q" style="font-size:220px; line-height:1; background:linear-gradient(180deg,var(--cyan),var(--violet)); -webkit-background-clip:text; background-clip:text; color:transparent;">?</div>
          <div class="b" style="font-size:28px; color:#cfd6ff; text-align:center;">AI has no idea</div>
        </div>
        <div class="abs chip" id="p8-warn" style="left:300px; top:700px; background:var(--red); color:#fff; font-size:32px; box-shadow:0 14px 36px rgba(255,59,48,0.45);">⚠ Missing info</div>
      </div></section>

      <!-- Context -->
      <section id="p9" class="panel clip" data-start="{{T:70.6}}" data-duration="{{D:70.6:80.1}}" data-track-index="2"><div class="pz">
        <div class="abs" style="left:0; right:0; top:80px; text-align:center;">
          <div class="eyebrow">What decides the answer</div>
          <div class="mask xb" style="font-size:150px; line-height:1.05; position:relative; display:inline-block;"><span id="p9-title">CONTEXT</span><div class="sweep" id="p9-sweep" style="left:-200px;"></div></div>
        </div>
        <div id="p9-cards">
          <div class="abs solid p9-c" style="left:90px; top:340px; width:280px; height:170px; padding:28px; display:flex; flex-direction:column; justify-content:center; gap:8px;"><div style="font-size:52px;">👤</div><div class="b" style="font-size:32px;">Yaaru neenga?</div></div>
          <div class="abs solid p9-c" style="left:400px; top:340px; width:280px; height:170px; padding:28px; display:flex; flex-direction:column; justify-content:center; gap:8px;"><div style="font-size:52px;">💰</div><div class="b" style="font-size:32px;">Budget enna?</div></div>
          <div class="abs solid p9-c" style="left:710px; top:340px; width:280px; height:170px; padding:28px; display:flex; flex-direction:column; justify-content:center; gap:8px;"><div style="font-size:52px;">🎯</div><div class="b" style="font-size:32px;">Goal enna?</div></div>
        </div>
        <div class="abs" id="p9-box" style="left:90px; right:90px; top:560px; height:200px; border-radius:40px; background:#fff; border:2px solid rgba(20,17,15,0.1); box-shadow:var(--shadow); padding:30px 36px;">
          <div class="m" style="font-size:30px; color:rgba(20,17,15,0.4);">Message AI…</div>
          <div id="p9-chips" style="display:flex; gap:14px; margin-top:22px;">
            <span class="chip p9-chip" style="background:#eef3ff; color:#2d5bd8;">👤 Biryani shop owner</span>
            <span class="chip p9-chip" style="background:#fff3df; color:#a8560c;">💰 ₹2,000</span>
            <span class="chip p9-chip" style="background:#e7f8ef; color:#0f8a57;">🎯 Profit up</span>
          </div>
        </div>
        <div class="abs" id="p9-cmp" style="left:90px; right:90px; top:350px; display:flex; flex-direction:column; gap:22px;">
          <div class="solid" style="padding:30px 36px; display:flex; justify-content:space-between; align-items:center;"><span class="b" style="font-size:38px; color:rgba(20,17,15,0.45);">Vague prompt</span><span class="b" style="font-size:38px; color:rgba(20,17,15,0.45);">→ vague answer</span></div>
          <div class="solid" style="padding:30px 36px; display:flex; justify-content:space-between; align-items:center; border:3px solid var(--gold);"><span class="xb" style="font-size:38px;">Clear context</span><span class="xb" style="font-size:38px; color:#c77a00;">→ clear answer</span></div>
        </div>
      </div></section>

      <!-- Endless message -->
      <section id="p10" class="panel clip" data-start="{{T:81.9}}" data-duration="{{D:81.9:84.7}}" data-track-index="2"><div class="pz">
        <div class="phone" style="left:305px; top:60px;">
          <div class="island"></div>
          <div class="scr" style="padding:110px 26px 26px;">
            <div class="hdr">AI Assistant</div>
            <div class="bub me" style="max-width:100%; overflow:hidden; height:560px;"><div id="p10-scroll" class="m" style="font-size:24px; line-height:1.45;"></div></div>
          </div>
        </div>
        <div class="abs solid" id="p10-count" style="left:60px; top:520px; width:250px; padding:26px 28px;"><div class="eyebrow" style="font-size:20px;">Words typed</div><div class="xb" style="font-size:64px;"><span id="p10-num">0</span></div></div>
      </div></section>

      <!-- ================= FULL-FRAME OVERLAYS ================= -->
      <div class="overlay clip" id="o1" data-start="0" data-duration="{{D:0:2.4}}" data-track-index="3">
        <div class="abs glass" id="o1-card" style="left:90px; right:90px; top:110px; padding:34px 40px;">
          <div style="display:flex; align-items:center; gap:14px;"><div style="width:44px; height:44px; border-radius:12px; background:linear-gradient(135deg,var(--blue),var(--violet));"></div><span class="b" style="font-size:28px;">AI Assistant</span></div>
          <div class="b" style="font-size:50px; line-height:1.2; margin-top:18px;">Weekend offer: <span style="background:linear-gradient(transparent 55%, rgba(255,182,39,0.65) 55%);">Buy 1 Get 1 FREE!</span></div>
        </div>
      </div>
      <div class="overlay clip" id="o2" data-start="{{T:5.1}}" data-duration="{{D:5.1:8.2}}" data-track-index="3">
        <div class="abs glass" id="o2-card" style="left:160px; right:160px; top:120px; padding:34px 44px;">
          <div class="eyebrow">Weekend profit</div>
          <div style="display:flex; align-items:center; justify-content:space-between;"><span class="xb" style="font-size:150px; line-height:1; color:var(--red);">₹0</span>
            <svg width="300" height="120" viewBox="0 0 300 120"><path id="o2-line" d="M10 30 L80 40 L140 70 L200 92 L290 104" fill="none" stroke="#ff3b30" stroke-width="10" stroke-linecap="round" stroke-linejoin="round"/></svg></div>
        </div>
      </div>
      <div class="overlay clip" id="o3" data-start="{{T:19.4}}" data-duration="{{D:19.4:21.3}}" data-track-index="3">
        <div class="abs glass" id="o3-card" style="left:150px; right:150px; top:130px; padding:28px 36px; display:flex; align-items:center; gap:18px;"><span style="font-size:56px;">✨</span><span class="b" style="font-size:40px; line-height:1.2;">AI: “Buy 1 Get 1 FREE!”</span></div>
      </div>
      <div class="overlay clip" id="o4" data-start="{{T:23.6}}" data-duration="{{D:23.6:28.8}}" data-track-index="3">
        <div class="abs" id="o4-poster" style="left:360px; top:110px; width:360px; height:440px; border-radius:20px; background:linear-gradient(160deg,#fffaf0,#ffe9c7); box-shadow:var(--shadow); display:flex; flex-direction:column; align-items:center; justify-content:center; overflow:hidden;">
          <div class="xb" style="font-size:86px; line-height:0.95; color:var(--brown);">BUY 1</div><div class="xb" style="font-size:86px; line-height:0.95; color:var(--saffron);">GET 1</div><div class="xb" style="font-size:96px; line-height:0.95; color:#e8301f;">FREE!</div>
          <div class="sweep" id="o4-sweep" style="left:-200px;"></div>
        </div>
        <div class="abs" id="o4-tape1" style="left:330px; top:96px; width:120px; height:40px; background:rgba(255,240,200,0.85); transform:rotate(-24deg);"></div>
        <div class="abs" id="o4-tape2" style="left:630px; top:96px; width:120px; height:40px; background:rgba(255,240,200,0.85); transform:rotate(24deg);"></div>
      </div>
      <div class="overlay clip" id="o5" data-start="{{T:34.6}}" data-duration="{{D:34.6:37.4}}" data-track-index="3">
        <div class="abs glass" id="o5-card" style="left:110px; right:110px; top:110px; padding:34px 40px;">
          <div style="display:flex; justify-content:space-between; align-items:baseline;"><span class="eyebrow">Evening kanakku</span><span class="xb" style="font-size:72px; color:var(--red);" id="o5-num">₹0</span></div>
          <svg viewBox="0 0 800 260" style="width:100%; height:260px; margin-top:10px; overflow:visible;"><defs><linearGradient id="o5-g" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="#ff3b30" stop-opacity="0.35"/><stop offset="1" stop-color="#ff3b30" stop-opacity="0"/></linearGradient></defs>
            <path id="o5-area" d="M0 40 L140 70 L260 60 L380 140 L500 120 L640 220 L800 250 L800 260 L0 260 Z" fill="url(#o5-g)"/>
            <path id="o5-line" d="M0 40 L140 70 L260 60 L380 140 L500 120 L640 220 L800 250" fill="none" stroke="#ff3b30" stroke-width="10" stroke-linecap="round" stroke-linejoin="round"/></svg>
        </div>
      </div>
      <div class="overlay clip" id="o6" data-start="{{T:56.2}}" data-duration="{{D:56.2:58.4}}" data-track-index="3">
        <div class="abs tech" id="o6-card" style="left:250px; right:250px; top:130px; padding:30px; text-align:center;">
          <div class="xb" style="font-size:130px; line-height:1; background:linear-gradient(90deg,var(--cyan),var(--violet)); -webkit-background-clip:text; background-clip:text; color:transparent;">1000×</div>
          <div class="b" style="font-size:30px; color:#cfd6ff;">your keyboard's suggestions</div>
        </div>
      </div>
      <div class="overlay clip" id="o7" data-start="{{T:66.6}}" data-duration="{{D:66.6:70.6}}" data-track-index="3">
        <div class="abs" id="o7-poster" style="left:360px; top:110px; width:360px; height:440px; border-radius:20px; background:linear-gradient(160deg,#fffaf0,#ffe9c7); box-shadow:var(--shadow); display:flex; flex-direction:column; align-items:center; justify-content:center;">
          <div class="xb" style="font-size:86px; line-height:0.95; color:var(--brown);">BUY 1</div><div class="xb" style="font-size:86px; line-height:0.95; color:var(--saffron);">GET 1</div><div class="xb" style="font-size:96px; line-height:0.95; color:#e8301f;">FREE!</div>
        </div>
        <div class="abs chip" id="o7-stamp" style="left:300px; top:470px; background:#14110f; color:#fff; font-size:34px; box-shadow:var(--shadow);">🤖 AI guessed this</div>
      </div>
      <div class="overlay clip" id="o8" data-start="{{T:84.7}}" data-duration="{{D:84.7:86.9}}" data-track-index="3">
        <div class="abs glass" id="o8-card" style="left:110px; right:110px; top:120px; padding:34px 40px;">
          <div class="eyebrow">Vanga AI Kathukalam</div>
          <div id="o8-days" style="display:flex; gap:16px; margin-top:18px;"></div>
        </div>
      </div>
      <div class="overlay clip" id="o9" data-start="{{T:86.9}}" data-duration="{{D:86.9:89.7}}" data-track-index="3">
        <div class="abs glass" id="o9-card" style="left:90px; top:130px; padding:24px 40px 24px 24px; display:flex; align-items:center; gap:22px;">
          <div style="width:92px; height:92px; border-radius:24px; background:linear-gradient(135deg,var(--saffron),var(--gold)); display:grid; place-items:center;" class="xb"><span style="font-size:40px; color:#fff;">JC</span></div>
          <div><div class="xb" style="font-size:50px; line-height:1;">Joshua Collins</div><div class="m" style="font-size:28px; color:rgba(20,17,15,0.6); margin-top:6px;">Vanga AI Kathukalam · Day 1 of 5</div></div>
        </div>
      </div>
      <div class="overlay clip" id="o10" data-start="{{T:89.7}}" data-duration="{{D:89.7:92.2}}" data-track-index="3">
        <div class="abs" id="o10-btns" style="left:0; right:0; top:130px; display:flex; flex-direction:column; align-items:center; gap:18px;">
          <div style="display:flex; gap:18px;">
            <div class="chip xb" id="o10-f" style="font-size:40px; padding:22px 44px; background:linear-gradient(135deg,var(--saffron),var(--gold)); color:#fff; box-shadow:0 16px 40px rgba(255,153,51,0.45);">+ Follow</div>
            <div class="chip xb glass" id="o10-s" style="font-size:40px; padding:22px 44px;">🔖 Save</div>
          </div>
          <div class="chip b glass" style="font-size:30px;">📅 Day 2 tomorrow</div>
        </div>
      </div>

      <div id="captions" class="clip" data-start="0" data-duration="{{T:92.2}}" data-track-index="5"></div>

      <audio id="vo" src="assets/media/vo-cut.m4a" data-start="0" data-duration="{{T:92.2}}" data-track-index="10" data-volume="1"></audio>
      <audio id="music" src="assets/media/music.m4a" data-start="0" data-duration="{{T:92.2}}" data-track-index="11" data-volume="0.09"></audio>
      <audio id="sfx0" src="assets/sfx/whoosh-short.mp3" data-start="{{T:2.4}}" data-duration="1.0" data-track-index="20" data-volume="0.22"></audio>
      <audio id="sfx1" src="assets/sfx/click-soft.mp3" data-start="{{T:2.5}}" data-duration="1.0" data-track-index="21" data-volume="0.4"></audio>
      <audio id="sfx2" src="assets/sfx/whoosh-short.mp3" data-start="{{T:5.1}}" data-duration="1.0" data-track-index="22" data-volume="0.22"></audio>
      <audio id="sfx3" src="assets/sfx/impact-bass-2.mp3" data-start="{{T:6.6}}" data-duration="1.0" data-track-index="23" data-volume="0.45"></audio>
      <audio id="sfx4" src="assets/sfx/whoosh-short.mp3" data-start="{{T:8.2}}" data-duration="1.0" data-track-index="20" data-volume="0.22"></audio>
      <audio id="sfx5" src="assets/sfx/click-soft.mp3" data-start="{{T:9.4}}" data-duration="1.0" data-track-index="21" data-volume="0.4"></audio>
      <audio id="sfx6" src="assets/sfx/typing.mp3" data-start="{{T:14.5}}" data-duration="2.0" data-track-index="22" data-volume="0.25"></audio>
      <audio id="sfx7" src="assets/sfx/whoosh-short.mp3" data-start="{{T:19.4}}" data-duration="1.0" data-track-index="23" data-volume="0.22"></audio>
      <audio id="sfx8" src="assets/sfx/whoosh-short.mp3" data-start="{{T:21.3}}" data-duration="1.0" data-track-index="20" data-volume="0.22"></audio>
      <audio id="sfx9" src="assets/sfx/impact-bass-1.mp3" data-start="{{T:21.35}}" data-duration="1.0" data-track-index="21" data-volume="0.5"></audio>
      <audio id="sfx10" src="assets/sfx/sparkle.mp3" data-start="{{T:21.4}}" data-duration="1.0" data-track-index="22" data-volume="0.35"></audio>
      <audio id="sfx11" src="assets/sfx/whoosh-short.mp3" data-start="{{T:23.6}}" data-duration="1.0" data-track-index="23" data-volume="0.22"></audio>
      <audio id="sfx12" src="assets/sfx/pop.mp3" data-start="{{T:26.0}}" data-duration="1.0" data-track-index="20" data-volume="0.4"></audio>
      <audio id="sfx13" src="assets/sfx/whoosh-short.mp3" data-start="{{T:28.8}}" data-duration="1.0" data-track-index="21" data-volume="0.22"></audio>
      <audio id="sfx14" src="assets/sfx/click-soft.mp3" data-start="{{T:29.6}}" data-duration="1.0" data-track-index="22" data-volume="0.35"></audio>
      <audio id="sfx15" src="assets/sfx/whoosh-short.mp3" data-start="{{T:34.6}}" data-duration="1.0" data-track-index="23" data-volume="0.22"></audio>
      <audio id="sfx16" src="assets/sfx/impact-bass-2.mp3" data-start="{{T:35.8}}" data-duration="1.0" data-track-index="20" data-volume="0.55"></audio>
      <audio id="sfx17" src="assets/sfx/whoosh-short.mp3" data-start="{{T:40.4}}" data-duration="1.0" data-track-index="21" data-volume="0.22"></audio>
      <audio id="sfx18" src="assets/sfx/impact-bass-1.mp3" data-start="{{T:40.85}}" data-duration="1.0" data-track-index="22" data-volume="0.4"></audio>
      <audio id="sfx19" src="assets/sfx/riser.mp3" data-start="{{T:45.6}}" data-duration="1.6" data-track-index="23" data-volume="0.22"></audio>
      <audio id="sfx20" src="assets/sfx/whoosh-short.mp3" data-start="{{T:48.6}}" data-duration="1.0" data-track-index="20" data-volume="0.22"></audio>
      <audio id="sfx21" src="assets/sfx/whoosh-short.mp3" data-start="{{T:51.0}}" data-duration="1.0" data-track-index="21" data-volume="0.22"></audio>
      <audio id="sfx22" src="assets/sfx/click.mp3" data-start="{{T:52.4}}" data-duration="1.0" data-track-index="22" data-volume="0.4"></audio>
      <audio id="sfx23" src="assets/sfx/whoosh-short.mp3" data-start="{{T:56.2}}" data-duration="1.0" data-track-index="23" data-volume="0.22"></audio>
      <audio id="sfx24" src="assets/sfx/sparkle.mp3" data-start="{{T:56.25}}" data-duration="1.0" data-track-index="20" data-volume="0.3"></audio>
      <audio id="sfx25" src="assets/sfx/whoosh-short.mp3" data-start="{{T:58.4}}" data-duration="1.0" data-track-index="21" data-volume="0.22"></audio>
      <audio id="sfx26" src="assets/sfx/notification.mp3" data-start="{{T:62.7}}" data-duration="1.0" data-track-index="22" data-volume="0.3"></audio>
      <audio id="sfx27" src="assets/sfx/whoosh-short.mp3" data-start="{{T:66.6}}" data-duration="1.0" data-track-index="23" data-volume="0.22"></audio>
      <audio id="sfx28" src="assets/sfx/pop.mp3" data-start="{{T:68.4}}" data-duration="1.0" data-track-index="20" data-volume="0.4"></audio>
      <audio id="sfx29" src="assets/sfx/whoosh-short.mp3" data-start="{{T:70.6}}" data-duration="1.0" data-track-index="21" data-volume="0.22"></audio>
      <audio id="sfx30" src="assets/sfx/click-soft.mp3" data-start="{{T:76.3}}" data-duration="1.0" data-track-index="22" data-volume="0.4"></audio>
      <audio id="sfx31" src="assets/sfx/click-soft.mp3" data-start="{{T:77.5}}" data-duration="1.0" data-track-index="23" data-volume="0.4"></audio>
      <audio id="sfx32" src="assets/sfx/click-soft.mp3" data-start="{{T:78.7}}" data-duration="1.0" data-track-index="20" data-volume="0.4"></audio>
      <audio id="sfx33" src="assets/sfx/chime.mp3" data-start="{{T:79.5}}" data-duration="1.0" data-track-index="21" data-volume="0.35"></audio>
      <audio id="sfx34" src="assets/sfx/whoosh-short.mp3" data-start="{{T:80.1}}" data-duration="1.0" data-track-index="22" data-volume="0.22"></audio>
      <audio id="sfx35" src="assets/sfx/whoosh-short.mp3" data-start="{{T:81.9}}" data-duration="1.0" data-track-index="23" data-volume="0.22"></audio>
      <audio id="sfx36" src="assets/sfx/whoosh-short.mp3" data-start="{{T:84.7}}" data-duration="1.0" data-track-index="20" data-volume="0.22"></audio>
      <audio id="sfx37" src="assets/sfx/click.mp3" data-start="{{T:85.8}}" data-duration="1.0" data-track-index="21" data-volume="0.35"></audio>
      <audio id="sfx38" src="assets/sfx/ping.mp3" data-start="{{T:89.75}}" data-duration="1.0" data-track-index="22" data-volume="0.35"></audio>
    </div>

    <script>
      (function () {
        const KEEP = /*KEEP*/;
        const SPEED = 1.1;
        // Original recording second -> edited timeline second
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
        let g = "";
        for (let i = 0; i < 200; i++) g += `<i style="display:block; height:30px; border-radius:9px; background:#e7e2db;"></i>`;
        $("#p1-grid").innerHTML = g;
        let days = "";
        for (let i = 1; i <= 5; i++) days += `<div class="p2-d" style="width:84px; height:84px; border-radius:50%; display:grid; place-items:center; background:${i === 1 ? "linear-gradient(135deg,var(--cyan),var(--violet))" : "#1c2246"}; color:#fff; font-family:PoppinsXB; font-size:34px; border:3px solid ${i === 1 ? "#fff" : "rgba(255,255,255,0.15)"}; box-shadow:${i === 1 ? "0 0 40px rgba(124,92,255,0.8)" : "none"};">${i}</div>`;
        $("#p2-days").innerHTML = days;
        let x2 = "";
        for (let i = 0; i < 18; i++) x2 += `<span class="chip p5-x" style="background:#fff; box-shadow:0 6px 16px rgba(20,17,15,0.08); font-size:26px; padding:10px 20px;">🍛 × 2</span>`;
        $("#p5-x2").innerHTML = x2;
        let rays = "";
        for (let i = 0; i < 18; i++) { const a = (i / 18) * Math.PI * 2; rays += `<path d="M0 0 L${(Math.cos(a - 0.07) * 900).toFixed(0)} ${(Math.sin(a - 0.07) * 900).toFixed(0)} L${(Math.cos(a + 0.07) * 900).toFixed(0)} ${(Math.sin(a + 0.07) * 900).toFixed(0)} Z" fill="rgba(255,182,39,0.16)"/>`; }
        $("#p4-rays").innerHTML = rays;
        const cr = rng(9), cc = ["#ff9933", "#ffb627", "#ff3b30", "#19c37d", "#2d7bff", "#7c5cff"];
        let conf = "";
        for (let i = 0; i < 46; i++) conf += `<i class="p4-cf" style="position:absolute; left:540px; top:420px; width:${(10 + cr() * 10).toFixed(0)}px; height:${(18 + cr() * 14).toFixed(0)}px; border-radius:3px; background:${cc[i % 6]}; display:block;" data-dx="${((cr() - 0.5) * 1100).toFixed(0)}" data-dy="${(-260 - cr() * 260).toFixed(0)}" data-r="${((cr() - 0.5) * 900).toFixed(0)}"></i>`;
        $("#p4-conf").innerHTML = conf;
        // neural net
        const nr = rng(5), layers = [4, 6, 6, 3], X = [180, 380, 580, 780];
        const nodes = layers.map((n, li) => Array.from({ length: n }, (_, k) => [X[li], 360 + (k - (n - 1) / 2) * 92]));
        let links = "", dots = "";
        for (let li = 0; li < 3; li++) nodes[li].forEach((a) => nodes[li + 1].forEach((b) => { links += `<path class="p6-ln" d="M${a[0]} ${a[1]} C ${a[0] + 100} ${a[1]}, ${b[0] - 100} ${b[1]}, ${b[0]} ${b[1]}" stroke="rgba(124,92,255,${(0.25 + nr() * 0.35).toFixed(2)})" stroke-width="2.5" fill="none"/>`; }));
        nodes.flat().forEach(([x, y]) => { dots += `<g class="p6-nd" transform="translate(${x} ${y})"><circle r="22" fill="#1c2246" stroke="rgba(41,211,255,0.9)" stroke-width="3"/><circle class="p6-core" r="9" fill="#29d3ff"/></g>`; });
        $("#p6-net").innerHTML = `<g>${links}</g><g>${dots}</g>`;
        const dr = rng(3);
        let docs = "";
        for (let i = 0; i < 16; i++) docs += `<div class="p6-doc" style="position:absolute; left:${(-120 - dr() * 60).toFixed(0)}px; top:${(120 + dr() * 460).toFixed(0)}px; width:74px; height:96px; border-radius:10px; background:#fff; box-shadow:0 8px 20px rgba(0,0,0,0.35); background-image:repeating-linear-gradient(180deg, transparent 0 12px, #cfd3e6 12px 16px); background-size:52px 100%; background-position:11px 14px; background-repeat:no-repeat;"></div>`;
        $("#p6-docs").innerHTML = docs;
        $("#p10-scroll").textContent = "Naanga Dolu Bolu, twins, biryani kadai vechirukkom. Chicken biryani ₹180, mutton ₹260. Rice kilo ₹90, chicken kilo ₹220, gas ₹1,100, 3 staff salary. Weekend la 150 plate pogum, margin 22%. Customers college pasanga. Budget ₹2,000. Goal: profit increase. Poster A3, Tamil + English, Bolu kadai offer vida better-ah irukkanum, aana loss aagakoodadhu… ".repeat(5);
        let od = "";
        for (let i = 1; i <= 5; i++) od += `<div class="o8-d" style="flex:1; height:110px; border-radius:24px; display:flex; flex-direction:column; align-items:center; justify-content:center; font-family:PoppinsXB; ${i === 1 ? "background:linear-gradient(135deg,var(--saffron),var(--gold)); color:#fff;" : i === 2 ? "background:#fff; border:3px solid var(--ink);" : "background:rgba(20,17,15,0.06); color:rgba(20,17,15,0.35);"}"><span style="font-size:20px; letter-spacing:3px;">DAY</span><span style="font-size:42px; line-height:1;">${i === 1 ? "✓" : i === 2 ? "2" : "🔒"}</span></div>`;
        $("#o8-days").innerHTML = od;

        // ---------- layout plan (original seconds) ----------
        const LAYOUT = [[0, "F"], [2.4, "S"], [5.1, "F"], [8.2, "S"], [19.4, "F"], [21.3, "S"], [23.6, "F"], [28.8, "S"], [34.6, "F"], [40.4, "S"], [48.6, "F"], [51.0, "S"], [56.2, "F"], [58.4, "S"], [66.6, "F"], [70.6, "S"], [80.1, "F"], [81.9, "S"], [84.7, "F"]];
        const layoutAt = (t) => { let l = "F"; LAYOUT.forEach(([s, v]) => { if (t >= s - 0.001) l = v; }); return l; };

        // ---------- captions: the script's own lines ----------
        // *x y* = saffron key words, !x y! = red
        const CAPS = [
          [0.15, 1.3, "ChatGPT eludhuna"], [1.3, 2.4, "*ORU LINE*", "big"], [2.4, 3.6, "!200 PERU!", "big"], [3.6, 5.1, "veliya nikkuraanga..."],
          [5.15, 6.6, "Aana *PROFIT*"], [6.6, 8.1, "!₹0!", "big"],
          [8.3, 9.4, "*Vanga AI Kathukalam*"], [9.4, 10.95, "*DAY 1*", "big"],
          [11.2, 13.95, "*Dolu Bolu*"], [14.2, 15.6, "weekend offer poster"], [15.6, 19.3, "oru *CATCHY* offer ezhudhi kudu"],
          [19.5, 21.2, "Stylish-ah ezhudhuchu"], [21.4, 23.5, "*BUY 1 GET 1 FREE!*"], [23.7, 27.4, "happy-ah print panni"], [27.4, 28.7, "*ottinaaru*"],
          [28.85, 29.6, "*SUNDAY*", "big"], [29.6, 30.6, "!200 PERU!", "big"], [30.6, 31.95, "*QUEUE-LA!*", "big"],
          [32.1, 34.5, "Appo dhaan *Dolu Bolu*..."], [34.7, 35.8, "Evening kanakku paathaa..."], [35.8, 37.35, "!FULL LOSS!", "big"],
          [37.5, 40.3, "Thappu AI-oda *ILLA*"], [40.9, 43.0, "ChatGPT pinnaadi irukradhu"], [43.0, 43.6, "*LLM*", "big"], [43.6, 45.6, "Large Language Model"], [45.8, 46.7, "Lakhs of pages padicha"], [46.7, 48.5, "*ORU BRAIN* 🧠"],
          [48.8, 50.75, "Adhu *YOSIKALA*"], [51.2, 52.3, "adutha best *WORD*"], [52.3, 53.7, "*PREDICT* pannudhu"], [53.9, 56.1, "Keyboard suggestion"], [56.3, 58.35, "*SUPER POWERFUL* version ⚡"],
          [58.45, 62.6, "*PROFIT MARGIN* enna nu"], [62.6, 64.9, "adhuku eppadi theriyum?"], [64.95, 66.55, "Avar *SOLLAVE ILLAYE* 🤦"], [66.7, 70.5, "Direct-ah *PREDICT* panni"],
          [70.8, 73.5, "*CONTEXT* dhaan"], [73.5, 76.2, "answer-a *DECIDE* pannum"], [76.3, 77.5, "Yaaru neenga?"], [77.5, 78.7, "Budget enna?"], [78.7, 80.0, "Goal enna?"], [80.1, 81.8, "*ELLAM SOLLUNGA* ✅"],
          [82.1, 83.0, "Daily *IVLO DETAIL*"], [83.0, 84.6, "type panna mudiyuma? 🤔"], [84.8, 85.8, "Innum *PERIYA COMEDY* 😂"], [85.8, 86.85, "*DAY 2*-la paakalam!"],
          [87.0, 89.6, "This is *JOSHUA COLLINS*"], [89.9, 90.5, "Let's build the"], [90.5, 91.1, "*LEVERAGE*", "big"], [91.1, 92.1, "together 🚀"],
        ];
        const capRoot = $("#captions");
        CAPS.forEach((c, i) => {
          const d = document.createElement("div");
          d.className = "cap " + (layoutAt(c[0] + 0.05) === "S" ? "split" : "full") + (c[3] ? " " + c[3] : "");
          d.id = "cap" + i;
          const parts = c[2].match(/\*[^*]+\*[^ ]*|![^!]+!|[^ ]+/g) || [];
          d.innerHTML = parts.flatMap((p) => {
            const cls = p[0] === "*" ? " k" : p[0] === "!" ? " r" : "";
            const txt = cls === " k" ? p.replace(/^\*([^*]+)\*/, "$1") : cls ? p.replace(/^!([^!]+)!/, "$1") : p;
            return cls ? [`<span class="w${cls}">${txt}</span>`] : txt.split(" ").map((w) => `<span class="w">${w}</span>`);
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
        // premium entrance: rise + de-blur + settle
        const enter = (el, t, o = {}) => tl.fromTo(el, { y: o.y ?? 60, opacity: 0, scale: o.s ?? 0.96, filter: "blur(14px)" }, { y: 0, opacity: 1, scale: 1, filter: "blur(0px)", duration: o.d ?? 0.7, ease: E, stagger: o.st ?? 0 }, t);
        const exit = (el, t, d = 0.35) => tl.to(el, { y: -40, opacity: 0, filter: "blur(10px)", duration: d, ease: "power2.in" }, t);
        const sweep = (el, t, w = 1300) => tl.fromTo(el, { x: 0 }, { x: w, duration: 0.9, ease: "power2.inOut" }, t);

        // camera: smooth morph between full frame and the bottom card
        const FULL = { clip: "inset(0px 0px 0px 0px round 0px)", y: 0, s: 1 };
        const CARD = { clip: "inset(880px 44px 40px 44px round 44px)", y: 600, s: 0.92 };
        tl.set("#vclip", { clipPath: FULL.clip }, 0);
        tl.set("#vframe", { y: 0, scale: 1 }, 0);
        LAYOUT.forEach(([t0, l], i) => {
          if (i === 0) return;
          const s = l === "S" ? CARD : FULL, t = T(t0);
          tl.to("#vclip", { clipPath: s.clip, duration: 0.42, ease: "expo.inOut" }, t - 0.06);
          tl.to("#vframe", { y: s.y, scale: s.s, duration: 0.42, ease: "expo.inOut" }, t - 0.06);
        });
        // jump cuts: alternate a gentle 4% reframe on every cut so edits read as intentional
        let acc = 0;
        KEEP.forEach(([s, e], k) => {
          tl.set("#vzoom", { scale: k % 2 ? 1.04 : 1.0 }, acc / SPEED);
          acc += e - s;
        });

        // captions: word-by-word pop with de-blur
        CAPS.forEach((c, i) => {
          const el = $("#cap" + i), ws = el.querySelectorAll(".w"), t0 = T(c[0]), t1 = T(c[1]);
          const st = Math.min(0.12, ((t1 - t0) * 0.5) / Math.max(1, ws.length));
          tl.set(el, { opacity: 1 }, t0);
          tl.fromTo(ws, { y: 40, scale: 0.6, opacity: 0, filter: "blur(8px)" }, { y: 0, scale: 1, opacity: 1, filter: "blur(0px)", duration: 0.32, ease: "back.out(2.2)", stagger: st }, t0);
          if (c[3] === "big") tl.fromTo(el, { rotation: -2 }, { rotation: 0, duration: 0.4, ease: "elastic.out(1, 0.5)" }, t0 + 0.05);
          tl.set(el, { opacity: 0 }, t1);
        });

        // ---- P1: 200 dot matrix ----
        enter("#p1-card", T(2.4));
        count($("#p1-num"), 0, 200, T(2.5), 1.1);
        tl.fromTo("#p1-grid i", { backgroundColor: "#e7e2db", scale: 0.6 }, { backgroundColor: "#ff9933", scale: 1, duration: 0.25, ease: "back.out(2)", stagger: { each: 0.0045, from: "start" } }, T(2.55));

        // ---- P2: series ----
        enter("#p2-card", T(8.2), { y: 80 });
        tl.fromTo("#p2-t1", { yPercent: 110 }, { yPercent: 0, duration: 0.7, ease: E }, T(8.35));
        tl.fromTo("#p2-t2", { yPercent: 110 }, { yPercent: 0, duration: 0.7, ease: E }, T(8.5));
        tl.fromTo(".p2-d", { scale: 0, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.45, ease: "back.out(2.4)", stagger: 0.07 }, T(8.8));
        tl.fromTo("#p2-prog", { scaleX: 0 }, { scaleX: 0.2, duration: 0.8, ease: E }, T(9.4));
        tl.fromTo(".p2-d:first-child", { scale: 1 }, { scale: 1.18, duration: 0.25, yoyo: true, repeat: 1, ease: "sine.inOut" }, T(9.45));

        // ---- P3: profile, then phone chat ----
        enter("#p3-profile", T(11.0), { y: 80 });
        exit("#p3-profile", T(13.85));
        tl.fromTo("#p3-phone", { y: 700, opacity: 0, rotationX: 25, transformPerspective: 1400 }, { y: 0, opacity: 1, rotationX: 0, duration: 0.8, ease: E }, T(13.95));
        const typed = $("#p3-typed"), MSG = "oru catchy offer ezhudhi kudu";
        tl.call(() => { typed.textContent = ""; }, null, T(11.0));
        const ty0 = T(14.5), ty1 = T(17.0);
        for (let i = 0; i <= MSG.length; i++) tl.call(() => { typed.textContent = MSG.substring(0, i); }, null, ty0 + (i / MSG.length) * (ty1 - ty0));
        tl.fromTo("#p3-caret", { opacity: 1 }, { opacity: 0, duration: 0.22, repeat: 9, yoyo: true, ease: "steps(1)" }, T(14.2));
        tl.fromTo("#p3-msg", { scale: 1 }, { scale: 1.04, duration: 0.12, yoyo: true, repeat: 1 }, ty1 + 0.1);
        tl.fromTo("#p3-think", { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.3, ease: E }, ty1 + 0.3);
        tl.fromTo("#p3-think i", { y: 0, opacity: 0.4 }, { y: -10, opacity: 1, duration: 0.3, yoyo: true, repeat: 5, stagger: 0.12, ease: "sine.inOut" }, ty1 + 0.4);

        // ---- P4: poster hero ----
        tl.fromTo("#p4-poster", { scale: 0.4, rotationY: -40, rotationX: 12, transformPerspective: 1600, opacity: 0, filter: "blur(16px)" }, { scale: 1, rotationY: 0, rotationX: 0, opacity: 1, filter: "blur(0px)", duration: 0.8, ease: E }, T(21.3));
        tl.fromTo("#p4-rays", { rotation: 0, scale: 0.6, svgOrigin: "0 0", opacity: 0 }, { rotation: 25, scale: 1, opacity: 1, duration: 2.1, ease: "power2.out" }, T(21.3));
        sweep("#p4-sweep", T(21.9), 1000);
        tl.fromTo(".p4-cf", { x: 0, y: 0, rotation: 0, opacity: 1 }, { x: (i, el) => +el.dataset.dx, y: (i, el) => +el.dataset.dy + 900, rotation: (i, el) => +el.dataset.r, opacity: 0, duration: 1.8, ease: "power1.out", stagger: 0.004 }, T(21.4));

        // ---- P5: Sunday + Bolu ----
        tl.fromTo("#p5-cal", { rotationX: -95, transformPerspective: 1200, opacity: 0 }, { rotationX: 0, opacity: 1, duration: 0.7, ease: E }, T(28.8));
        enter("#p5-stat", T(28.95));
        count($("#p5-num"), 0, 200, T(29.6), 1.0);
        tl.fromTo(".p5-x", { scale: 0, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.35, ease: "back.out(2.6)", stagger: 0.05 }, T(30.0));
        tl.to(["#p5-cal", "#p5-stat", "#p5-x2"], { opacity: 0, y: -40, filter: "blur(10px)", duration: 0.35, ease: "power2.in" }, T(31.85));
        tl.set("#p5-bolu", { opacity: 0 }, T(28.8));
        enter("#p5-bolu", T(32.05), { y: 90 });
        tl.fromTo("#p5-bolu", { rotation: 0 }, { rotation: -1.5, duration: 0.6, yoyo: true, repeat: 1, ease: "sine.inOut" }, T(33.0));

        // ---- P6: LLM ----
        enter("#p6-intro", T(40.6), { y: 40 });
        tl.to("#p6-intro", { y: -60, opacity: 0, filter: "blur(12px)", duration: 0.35, ease: "power2.in" }, T(42.75));
        tl.fromTo(".p6-l", { yPercent: 120, opacity: 0 }, { yPercent: 0, opacity: 1, duration: 0.7, ease: E, stagger: 0.08 }, T(43.0));
        tl.fromTo("#p6-words span", { y: 30, opacity: 0, filter: "blur(8px)" }, { y: 0, opacity: 1, filter: "blur(0px)", duration: 0.5, ease: E, stagger: 0.35 }, T(43.6));
        tl.to(["#p6-letters", "#p6-words"], { opacity: 0, scale: 0.9, filter: "blur(12px)", duration: 0.4, ease: "power2.in" }, T(45.4));
        tl.set(["#p6-net", "#p6-count"], { opacity: 0 }, T(40.4));
        tl.to(["#p6-net", "#p6-count"], { opacity: 1, duration: 0.3 }, T(45.6));
        tl.fromTo(".p6-ln", { strokeDasharray: 400, strokeDashoffset: 400 }, { strokeDashoffset: 0, duration: 0.8, ease: "power2.out", stagger: 0.008 }, T(45.6));
        tl.fromTo(".p6-nd", { scale: 0, transformOrigin: "50% 50%" }, { scale: 1, duration: 0.45, ease: "back.out(2.5)", stagger: 0.03 }, T(45.65));
        tl.fromTo(".p6-doc", { x: 0, opacity: 0, rotation: -10 }, { x: 300, opacity: 1, rotation: 0, duration: 0.5, ease: "power2.out", stagger: 0.06 }, T(45.8));
        tl.to(".p6-doc", { x: 330, scale: 0.2, opacity: 0, duration: 0.3, ease: "power2.in", stagger: 0.06 }, T(46.3));
        tl.fromTo(".p6-core", { fill: "#29d3ff" }, { fill: "#ffffff", duration: 0.2, yoyo: true, repeat: 5, stagger: { each: 0.02, from: "start" } }, T(46.4));
        count($("#p6-num"), 0, 100000, T(45.8), 1.8);

        // ---- P7: predict ----
        enter("#p7 .solid", T(51.0));
        tl.set("#p7-fill", { opacity: 0 }, T(51.0));
        tl.fromTo(".tok", { x: -40, opacity: 0 }, { x: 0, opacity: 1, duration: 0.5, ease: E, stagger: 0.12 }, T(51.3));
        tl.fromTo(".tok .fl", { scaleX: 0 }, { scaleX: 1, duration: 0.9, ease: E, stagger: 0.12 }, T(51.4));
        tl.fromTo("#p7-fill", { opacity: 0, y: 220, scale: 0.7 }, { opacity: 1, y: 0, scale: 1, duration: 0.6, ease: "back.out(1.8)" }, T(52.4));
        tl.to(["#p7-t2", "#p7-t3"], { opacity: 0.25, duration: 0.3 }, T(52.4));
        tl.fromTo("#p7-kb", { y: 60, opacity: 0 }, { y: 0, opacity: 1, duration: 0.5, ease: E }, T(53.9));
        tl.to("#p7-kb", { scale: 1.06, backgroundColor: "#ffffff", boxShadow: "0 0 0 3px #7c5cff, 0 20px 60px rgba(124,92,255,0.45)", duration: 0.5, ease: E }, T(55.0));

        // ---- P8: missing info ----
        enter("#p8-rcpt", T(58.4));
        enter("#p8-ai", T(58.55));
        tl.fromTo("#p8-rows > div", { opacity: 0, x: -20 }, { opacity: 1, x: 0, duration: 0.4, ease: E, stagger: 0.12 }, T(58.8));
        tl.fromTo("#p8-shim", { x: 0 }, { x: 700, duration: 1.1, repeat: 4, ease: "power1.inOut" }, T(59.5));
        tl.fromTo("#p8-q", { y: 0 }, { y: -18, duration: 0.6, yoyo: true, repeat: 7, ease: "sine.inOut" }, T(59.0));
        tl.fromTo("#p8-warn", { scale: 0.4, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.5, ease: "back.out(2.4)" }, T(62.7));

        // ---- P9: context ----
        tl.fromTo("#p9-title", { yPercent: 110 }, { yPercent: 0, duration: 0.8, ease: E }, T(70.8));
        sweep("#p9-sweep", T(71.4), 1000);
        enter("#p9-cmp > div", T(73.6), { st: 0.18 });
        tl.to("#p9-cmp", { opacity: 0, y: -30, filter: "blur(10px)", duration: 0.35, ease: "power2.in" }, T(76.0));
        tl.set(["#p9-box", ".p9-c"], { opacity: 0 }, T(70.6));
        enter("#p9-box", T(76.1), { y: 50 });
        tl.set(".p9-chip", { opacity: 0 }, T(70.6));
        [[76.3, 0], [77.5, 1], [78.7, 2]].forEach(([t, i]) => {
          const c = $$(".p9-c")[i], chip = $$(".p9-chip")[i];
          tl.fromTo(c, { y: -60, opacity: 0, scale: 0.9, filter: "blur(10px)" }, { y: 0, opacity: 1, scale: 1, filter: "blur(0px)", duration: 0.45, ease: E }, T(t));
          tl.to(c, { y: 260, scale: 0.5, opacity: 0, duration: 0.4, ease: "power3.in" }, T(t) + 0.55);
          tl.fromTo(chip, { scale: 0.4, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.4, ease: "back.out(2.6)" }, T(t) + 0.9);
        });
        tl.to("#p9-box", { borderColor: "#ffb627", boxShadow: "0 0 0 4px rgba(255,182,39,0.5), 0 30px 80px rgba(255,153,51,0.35)", duration: 0.4, ease: E }, T(79.5));

        // ---- P10: endless message ----
        enter("#p10 .phone", T(81.9), { y: 120 });
        tl.fromTo("#p10-scroll", { y: 0 }, { y: -1400, duration: T(84.7) - T(81.9), ease: "power1.in" }, T(81.9));
        enter("#p10-count", T(82.2));
        count($("#p10-num"), 0, 2840, T(82.2), T(84.6) - T(82.2));

        // ---- full-frame overlays ----
        enter("#o1-card", 0.15);
        enter("#o2-card", T(5.1));
        tl.fromTo("#o2-line", { strokeDasharray: 400, strokeDashoffset: 400 }, { strokeDashoffset: 0, duration: 0.9, ease: "power2.inOut" }, T(5.4));
        enter("#o3-card", T(19.45), { s: 0.85 });
        tl.fromTo("#o4-poster", { y: -700, rotation: -8 }, { y: 0, rotation: 3, duration: 0.8, ease: "back.out(1.2)" }, T(26.0));
        tl.set("#o4-poster", { y: -700 }, T(23.6));
        tl.fromTo(["#o4-tape1", "#o4-tape2"], { opacity: 0, scale: 1.6 }, { opacity: 1, scale: 1, duration: 0.2, stagger: 0.12 }, T(26.7));
        tl.set(["#o4-tape1", "#o4-tape2"], { opacity: 0 }, T(23.6));
        sweep("#o4-sweep", T(27.1), 700);
        enter("#o5-card", T(34.6));
        tl.fromTo("#o5-line", { strokeDasharray: 1100, strokeDashoffset: 1100 }, { strokeDashoffset: 0, duration: 1.0, ease: "power2.in" }, T(34.8));
        tl.fromTo("#o5-area", { opacity: 0 }, { opacity: 1, duration: 0.5 }, T(35.5));
        count($("#o5-num"), 0, -18400, T(34.8), 1.1, (v) => (v < 0 ? "−₹" : "₹") + Math.abs(Math.round(v)).toLocaleString("en-IN"));
        enter("#o6-card", T(56.25), { s: 0.8 });
        tl.fromTo("#o7-poster", { scale: 0.5, opacity: 0, rotation: -10, filter: "blur(12px)" }, { scale: 1, opacity: 1, rotation: 3, filter: "blur(0px)", duration: 0.7, ease: E }, T(66.7));
        tl.fromTo("#o7-stamp", { scale: 0.4, opacity: 0 }, { scale: 1, opacity: 1, duration: 0.45, ease: "back.out(2.4)" }, T(68.4));
        enter("#o8-card", T(84.75));
        tl.fromTo(".o8-d", { y: 30, opacity: 0 }, { y: 0, opacity: 1, duration: 0.45, ease: E, stagger: 0.07 }, T(84.9));
        tl.fromTo(".o8-d:nth-child(2)", { boxShadow: "0 0 0 0 rgba(255,182,39,0)" }, { boxShadow: "0 0 0 10px rgba(255,182,39,0.45)", duration: 0.35, yoyo: true, repeat: 3, ease: "sine.inOut" }, T(85.8));
        tl.fromTo("#o9-card", { x: -600, opacity: 0, filter: "blur(10px)" }, { x: 0, opacity: 1, filter: "blur(0px)", duration: 0.7, ease: E }, T(87.0));
        enter("#o10-btns", T(89.75));
        tl.fromTo("#o10-f", { scale: 1 }, { scale: 1.07, duration: 0.35, yoyo: true, repeat: 3, ease: "sine.inOut" }, T(90.5));

        window.__timelines["main"] = tl;
      })();
    </script>
  </body>
</html>
