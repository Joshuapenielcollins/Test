// Vector art for the Dolu Bolu series: characters, shops, street, crowd.
// Every function returns an SVG string so scenes can stamp identical art.
(function () {
  const C = {
    saffron: "#FF9933",
    saffronDeep: "#E8751A",
    brown: "#3B1F0E",
    brownMid: "#6B3A1E",
    yellow: "#FFD34D",
    cream: "#FFF4DE",
    skin: "#B9774A",
    skinShade: "#9A5F38",
    skinBolu: "#A86A40",
    hair: "#17110D",
    doluShirt: "#8EC8F0",
    doluShirtShade: "#6FAAD6",
    boluShirt: "#1F5B3A",
    boluShirtShade: "#174A2F",
    veshti: "#FBF8F0",
    veshtiShade: "#E3DCCB",
    border: "#D4A017",
    red: "#E53935",
  };

  // Seeded PRNG so the crowd is identical on every frame and render.
  function rng(seed) {
    let s = seed >>> 0;
    return function () {
      s = (s * 1664525 + 1013904223) >>> 0;
      return s / 4294967296;
    };
  }

  // ---------- DOLU ANNA ----------
  // expr: neutral | panic | happy | focus | shock | confused | tired | grin
  function dolu(opts = {}) {
    const expr = opts.expr || "neutral";
    const id = opts.id || "dolu";
    const glasses = !!opts.glasses;
    const sweat = opts.sweat || expr === "panic" || expr === "tired";
    const ladle = !!opts.ladle;
    const phone = !!opts.phone;

    const eyes = {
      neutral: `<ellipse cx="172" cy="196" rx="11" ry="13" fill="#fff"/><ellipse cx="228" cy="196" rx="11" ry="13" fill="#fff"/><circle cx="174" cy="198" r="6" fill="${C.hair}"/><circle cx="226" cy="198" r="6" fill="${C.hair}"/>`,
      panic: `<ellipse cx="172" cy="194" rx="15" ry="18" fill="#fff"/><ellipse cx="228" cy="194" rx="15" ry="18" fill="#fff"/><circle cx="172" cy="194" r="5" fill="${C.hair}"/><circle cx="228" cy="194" r="5" fill="${C.hair}"/>`,
      happy: `<path d="M160 200 Q172 186 184 200" stroke="${C.hair}" stroke-width="6" fill="none" stroke-linecap="round"/><path d="M216 200 Q228 186 240 200" stroke="${C.hair}" stroke-width="6" fill="none" stroke-linecap="round"/>`,
      grin: `<path d="M160 200 Q172 188 184 200" stroke="${C.hair}" stroke-width="6" fill="none" stroke-linecap="round"/><path d="M216 200 Q228 188 240 200" stroke="${C.hair}" stroke-width="6" fill="none" stroke-linecap="round"/>`,
      focus: `<ellipse cx="172" cy="200" rx="10" ry="7" fill="#fff"/><ellipse cx="228" cy="200" rx="10" ry="7" fill="#fff"/><circle cx="174" cy="203" r="5" fill="${C.hair}"/><circle cx="230" cy="203" r="5" fill="${C.hair}"/>`,
      shock: `<ellipse cx="172" cy="194" rx="14" ry="17" fill="#fff"/><ellipse cx="228" cy="194" rx="14" ry="17" fill="#fff"/><circle cx="172" cy="196" r="4" fill="${C.hair}"/><circle cx="228" cy="196" r="4" fill="${C.hair}"/>`,
      confused: `<ellipse cx="172" cy="198" rx="11" ry="12" fill="#fff"/><ellipse cx="228" cy="194" rx="12" ry="15" fill="#fff"/><circle cx="176" cy="200" r="5" fill="${C.hair}"/><circle cx="232" cy="196" r="6" fill="${C.hair}"/>`,
      tired: `<path d="M160 200 L184 200" stroke="${C.hair}" stroke-width="6" stroke-linecap="round"/><path d="M216 200 L240 200" stroke="${C.hair}" stroke-width="6" stroke-linecap="round"/><path d="M162 208 Q172 214 182 208" stroke="${C.skinShade}" stroke-width="3" fill="none"/><path d="M218 208 Q228 214 238 208" stroke="${C.skinShade}" stroke-width="3" fill="none"/>`,
    }[expr];

    const brows = {
      neutral: `<path d="M156 174 Q172 166 188 174" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/><path d="M212 174 Q228 166 244 174" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/>`,
      panic: `<path d="M156 166 Q172 156 188 168" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/><path d="M212 168 Q228 156 244 166" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/>`,
      happy: `<path d="M156 170 Q172 160 188 170" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/><path d="M212 170 Q228 160 244 170" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/>`,
      grin: `<path d="M156 170 Q172 160 188 170" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/><path d="M212 170 Q228 160 244 170" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/>`,
      focus: `<path d="M156 182 L188 178" stroke="${C.hair}" stroke-width="9" stroke-linecap="round"/><path d="M212 178 L244 182" stroke="${C.hair}" stroke-width="9" stroke-linecap="round"/>`,
      shock: `<path d="M156 162 Q172 152 188 162" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/><path d="M212 162 Q228 152 244 162" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/>`,
      confused: `<path d="M156 180 L188 176" stroke="${C.hair}" stroke-width="9" stroke-linecap="round"/><path d="M212 168 Q228 156 244 164" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/>`,
      tired: `<path d="M156 178 Q172 182 188 176" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/><path d="M212 176 Q228 182 244 178" stroke="${C.hair}" stroke-width="9" fill="none" stroke-linecap="round"/>`,
    }[expr];

    const mouth = {
      neutral: `<path d="M184 262 Q200 270 216 262" stroke="#5A2412" stroke-width="5" fill="none" stroke-linecap="round"/>`,
      panic: `<ellipse cx="200" cy="268" rx="15" ry="19" fill="#5A2412"/><ellipse cx="200" cy="276" rx="9" ry="6" fill="#C9504A"/>`,
      happy: `<path d="M172 254 Q200 296 228 254 Z" fill="#5A2412"/><path d="M178 256 L222 256 L218 264 L182 264 Z" fill="#fff"/>`,
      grin: `<path d="M166 252 Q200 306 234 252 Z" fill="#5A2412"/><path d="M172 254 L228 254 L222 266 L178 266 Z" fill="#fff"/><ellipse cx="200" cy="282" rx="12" ry="6" fill="#C9504A"/>`,
      focus: `<path d="M188 262 Q200 266 212 262" stroke="#5A2412" stroke-width="5" fill="none" stroke-linecap="round"/><ellipse cx="208" cy="270" rx="7" ry="6" fill="#D9606A"/>`,
      shock: `<ellipse cx="200" cy="270" rx="12" ry="16" fill="#5A2412"/>`,
      confused: `<path d="M184 266 Q192 258 200 266 Q208 274 216 264" stroke="#5A2412" stroke-width="5" fill="none" stroke-linecap="round"/>`,
      tired: `<path d="M184 270 Q200 260 216 270" stroke="#5A2412" stroke-width="5" fill="none" stroke-linecap="round"/>`,
    }[expr];

    // Mustache lifts when he smiles.
    const stache =
      expr === "happy" || expr === "grin"
        ? `<path d="M150 238 Q176 222 200 236 Q224 222 250 238 Q236 254 200 246 Q164 254 150 238 Z" fill="${C.hair}"/>`
        : expr === "panic" || expr === "shock"
          ? `<path d="M152 246 Q176 232 200 242 Q224 232 248 246 Q236 258 200 250 Q164 258 152 246 Z" fill="${C.hair}"/>`
          : `<path d="M148 248 Q174 228 200 242 Q226 228 252 248 Q238 262 200 252 Q162 262 148 248 Z" fill="${C.hair}"/>`;

    const sweatDrops = sweat
      ? `<g class="${id}-sweat"><path d="M122 160 Q114 176 122 184 Q130 176 122 160 Z" fill="#9FD8FF" stroke="#fff" stroke-width="2"/><path d="M282 176 Q274 192 282 200 Q290 192 282 176 Z" fill="#9FD8FF" stroke="#fff" stroke-width="2"/><path d="M268 130 Q262 142 268 148 Q274 142 268 130 Z" fill="#9FD8FF" stroke="#fff" stroke-width="2"/></g>`
      : "";

    const specs = glasses
      ? `<g stroke="#2A1A10" stroke-width="4" fill="rgba(255,255,255,0.18)"><rect x="152" y="208" width="40" height="24" rx="8"/><rect x="208" y="208" width="40" height="24" rx="8"/><path d="M192 218 L208 218" fill="none"/></g>`
      : "";

    const ladleSvg = ladle
      ? `<g class="${id}-ladle"><rect x="318" y="300" width="12" height="220" rx="6" fill="#B8B8B8" transform="rotate(-18 324 410)"/><ellipse cx="362" cy="292" rx="36" ry="20" fill="#C9C9C9" stroke="#8E8E8E" stroke-width="4" transform="rotate(-18 362 292)"/></g>`
      : "";

    const phoneSvg = phone
      ? `<g class="${id}-phone"><rect x="168" y="420" width="72" height="128" rx="12" fill="#1B1B22" stroke="#444" stroke-width="3"/><rect x="174" y="430" width="60" height="104" rx="6" fill="#3B6EF5" opacity="0.9"/></g>`
      : "";

    return `
<svg class="char char-dolu" id="${id}" viewBox="0 0 400 760" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <radialGradient id="${id}-face" cx="0.45" cy="0.4" r="0.7"><stop offset="0" stop-color="#C98A5B"/><stop offset="1" stop-color="${C.skinShade}"/></radialGradient>
    <linearGradient id="${id}-shirt" x1="0" x2="1"><stop offset="0" stop-color="${C.doluShirt}"/><stop offset="1" stop-color="${C.doluShirtShade}"/></linearGradient>
  </defs>
  <!-- veshti -->
  <path d="M96 560 L304 560 L322 760 L78 760 Z" fill="${C.veshti}"/>
  <path d="M200 560 L210 760 L196 760 Z" fill="${C.veshtiShade}"/>
  <rect x="94" y="556" width="212" height="16" rx="6" fill="${C.border}"/>
  <!-- belly + shirt -->
  <path d="M84 360 Q72 470 96 566 L304 566 Q328 470 316 360 Q300 318 200 312 Q100 318 84 360 Z" fill="url(#${id}-shirt)"/>
  <path d="M200 316 L200 566" stroke="#5E93BC" stroke-width="3"/>
  <circle cx="200" cy="380" r="5" fill="#fff"/><circle cx="200" cy="440" r="5" fill="#fff"/><circle cx="200" cy="500" r="5" fill="#fff"/>
  <path d="M164 316 L200 352 L236 316 Z" fill="${C.skin}"/>
  <path d="M152 312 L200 356 L182 300 Z" fill="${C.doluShirt}" stroke="#5E93BC" stroke-width="2"/>
  <path d="M248 312 L200 356 L218 300 Z" fill="${C.doluShirt}" stroke="#5E93BC" stroke-width="2"/>
  <!-- half sleeves + arms -->
  <g class="${id}-armL"><path d="M86 350 Q50 380 48 440 L92 446 Q96 400 112 380 Z" fill="${C.doluShirtShade}"/><path d="M50 440 Q44 500 70 540 L104 528 Q90 490 92 446 Z" fill="${C.skin}"/><circle cx="86" cy="538" r="22" fill="${C.skin}"/></g>
  <g class="${id}-armR"><path d="M314 350 Q350 380 352 440 L308 446 Q304 400 288 380 Z" fill="${C.doluShirtShade}"/><path d="M350 440 Q356 500 330 540 L296 528 Q310 490 308 446 Z" fill="${C.skin}"/><circle cx="314" cy="538" r="22" fill="${C.skin}"/></g>
  <!-- towel on shoulder -->
  <path d="M232 318 Q290 318 318 350 L330 440 L300 446 L292 372 Q262 344 226 340 Z" fill="#F4E9D2" stroke="#E0C99A" stroke-width="3"/>
  <path d="M300 420 L330 420 M298 432 L330 432" stroke="${C.red}" stroke-width="4"/>
  <!-- neck + head -->
  <rect x="176" y="276" width="48" height="46" fill="${C.skinShade}"/>
  <ellipse cx="200" cy="208" rx="98" ry="102" fill="url(#${id}-face)"/>
  <ellipse cx="104" cy="214" rx="16" ry="26" fill="${C.skin}"/><ellipse cx="296" cy="214" rx="16" ry="26" fill="${C.skin}"/>
  <!-- hair -->
  <path d="M104 186 Q100 96 200 92 Q300 96 296 186 Q284 132 200 126 Q116 132 104 186 Z" fill="${C.hair}"/>
  <!-- cheeks -->
  <ellipse cx="148" cy="240" rx="20" ry="12" fill="#D9806A" opacity="0.35"/><ellipse cx="252" cy="240" rx="20" ry="12" fill="#D9806A" opacity="0.35"/>
  <g class="${id}-brows">${brows}</g>
  <g class="${id}-eyes">${eyes}</g>
  ${specs}
  <path d="M200 206 Q190 232 200 236 Q210 232 200 206" fill="${C.skinShade}"/>
  <g class="${id}-mouth">${mouth}</g>
  ${stache}
  ${sweatDrops}
  ${ladleSvg}
  ${phoneSvg}
</svg>`;
  }

  // ---------- BOLU ANNA ----------
  function bolu(opts = {}) {
    const id = opts.id || "bolu";
    return `
<svg class="char char-bolu" id="${id}" viewBox="0 0 400 820" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <radialGradient id="${id}-face" cx="0.45" cy="0.4" r="0.7"><stop offset="0" stop-color="#B97B4E"/><stop offset="1" stop-color="#8A5530"/></radialGradient>
  </defs>
  <path d="M120 580 L280 580 L296 820 L104 820 Z" fill="${C.veshti}"/>
  <rect x="118" y="576" width="164" height="14" rx="5" fill="${C.border}"/>
  <path d="M110 330 Q100 460 120 586 L280 586 Q300 460 290 330 Q270 300 200 296 Q130 300 110 330 Z" fill="${C.boluShirt}"/>
  <path d="M200 300 L200 586" stroke="${C.boluShirtShade}" stroke-width="3"/>
  <path d="M170 300 L200 336 L230 300 Z" fill="${C.skinBolu}"/>
  <path d="M160 296 L200 340 L184 286 Z" fill="${C.boluShirt}" stroke="#0F3A24" stroke-width="2"/>
  <path d="M240 296 L200 340 L216 286 Z" fill="${C.boluShirt}" stroke="#0F3A24" stroke-width="2"/>
  <!-- folded arms -->
  <g class="${id}-arms">
    <path d="M112 340 Q80 400 110 460 L290 470 Q320 400 288 340 L270 420 L130 420 Z" fill="${C.boluShirtShade}"/>
    <rect x="112" y="424" width="180" height="48" rx="24" fill="${C.boluShirt}" stroke="#0F3A24" stroke-width="3"/>
    <ellipse cx="128" cy="448" rx="22" ry="20" fill="${C.skinBolu}"/><ellipse cx="276" cy="448" rx="22" ry="20" fill="${C.skinBolu}"/>
  </g>
  <rect x="180" y="250" width="40" height="52" fill="#8A5530"/>
  <ellipse cx="200" cy="186" rx="76" ry="94" fill="url(#${id}-face)"/>
  <ellipse cx="124" cy="196" rx="12" ry="22" fill="${C.skinBolu}"/><ellipse cx="276" cy="196" rx="12" ry="22" fill="${C.skinBolu}"/>
  <!-- neatly combed hair with side parting -->
  <path d="M124 170 Q118 84 204 84 Q284 88 278 170 Q270 120 214 116 L170 120 Q134 128 124 170 Z" fill="${C.hair}"/>
  <path d="M170 92 Q164 104 168 120" stroke="#3A2A20" stroke-width="3" fill="none"/>
  <!-- sharp eyes, one brow raised -->
  <path d="M152 162 L188 168" stroke="${C.hair}" stroke-width="7" stroke-linecap="round"/>
  <path d="M212 160 Q230 148 248 158" stroke="${C.hair}" stroke-width="7" fill="none" stroke-linecap="round"/>
  <path d="M156 186 Q172 178 188 186 Q172 192 156 186 Z" fill="#fff"/><circle cx="176" cy="186" r="5" fill="${C.hair}"/>
  <path d="M212 184 Q228 174 244 184 Q228 192 212 184 Z" fill="#fff"/><circle cx="232" cy="184" r="5" fill="${C.hair}"/>
  <path d="M200 192 Q192 216 200 220 Q208 216 200 192" fill="#7A4A2A"/>
  <!-- thin mustache + smirk -->
  <path d="M172 232 Q200 222 228 232 Q200 230 172 232 Z" fill="${C.hair}" stroke="${C.hair}" stroke-width="3"/>
  <g class="${id}-smirk"><path d="M178 248 Q206 256 232 240" stroke="#4A1E10" stroke-width="5" fill="none" stroke-linecap="round"/></g>
  <!-- toothpick -->
  <g class="${id}-pick"><path d="M228 244 L282 226" stroke="#E8C98A" stroke-width="4" stroke-linecap="round"/></g>
</svg>`;
  }

  // ---------- Simple customer silhouette for crowds ----------
  function person(x, y, s, shirt, skin, hair, id) {
    return `<g transform="translate(${x} ${y}) scale(${s})"><g class="crowd-p" ${id ? `id="${id}"` : ""}>
      <ellipse cx="0" cy="96" rx="34" ry="8" fill="rgba(40,20,5,0.25)"/>
      <path d="M-26 20 Q-30 70 -22 96 L22 96 Q30 70 26 20 Q16 4 0 4 Q-16 4 -26 20 Z" fill="${shirt}"/>
      <circle cx="0" cy="-14" r="18" fill="${skin}"/>
      <path d="M-18 -16 Q-18 -36 0 -36 Q18 -36 18 -16 Q10 -28 0 -28 Q-10 -28 -18 -16 Z" fill="${hair}"/>
    </g></g>`;
  }

  function crowd(opts = {}) {
    const r = rng(opts.seed || 11);
    const n = opts.count || 60;
    const shirts = ["#E8751A", "#3F7CAC", "#C2185B", "#2E7D32", "#F9A825", "#6D4C41", "#5E35B1", "#00897B", "#EF6C00", "#FFFFFF"];
    const skins = ["#B9774A", "#9A5F38", "#C98A5B", "#8A5530", "#A86A40"];
    let out = "";
    // Queue snakes from the shop door (bottom-left) up the road toward the vanishing point.
    const pts = [];
    for (let i = 0; i < n; i++) {
      const k = i / n;
      const depth = Math.pow(k, 0.8);
      const x = 330 + depth * 200 + (i % 3 - 1) * 70 * (1 - depth * 0.7) + (r() - 0.5) * 30 * (1 - depth);
      const y = 1500 - depth * 640 + (r() - 0.5) * 30;
      const s = 1.35 * (1 - depth * 0.72);
      pts.push([x, y, s, i]);
    }
    pts.sort((a, b) => a[1] - b[1]);
    for (const [x, y, s, i] of pts) {
      out += person(x, y, s, shirts[Math.floor(r() * shirts.length)], skins[Math.floor(r() * skins.length)], "#17110D", opts.idPrefix ? `${opts.idPrefix}${i}` : "");
    }
    return out;
  }

  // ---------- Handi (biryani pot) ----------
  function handi(x, y, s, id) {
    return `<g ${id ? `id="${id}"` : ""} transform="translate(${x} ${y}) scale(${s})">
      <ellipse cx="0" cy="96" rx="120" ry="18" fill="rgba(30,10,0,0.35)"/>
      <path d="M-110 0 Q-130 90 -60 100 L60 100 Q130 90 110 0 Z" fill="#8C8F96"/>
      <path d="M-110 0 Q-130 90 -60 100 L-40 100 Q-100 80 -90 0 Z" fill="#6A6D74"/>
      <ellipse cx="0" cy="0" rx="112" ry="26" fill="#A6A9B0"/>
      <ellipse cx="0" cy="2" rx="96" ry="18" fill="#F2B640"/>
      <g fill="#FFE8A3" opacity="0.9"><circle cx="-40" cy="0" r="6"/><circle cx="-10" cy="-4" r="5"/><circle cx="20" cy="2" r="6"/><circle cx="50" cy="-2" r="5"/><circle cx="0" cy="6" r="5"/></g>
      <g fill="#7A3A12"><circle cx="-26" cy="4" r="7"/><circle cx="34" cy="-2" r="8"/><circle cx="6" cy="-6" r="6"/></g>
    </g>`;
  }

  function steam(x, y, s, cls) {
    return `<g class="${cls || "steam"}" transform="translate(${x} ${y}) scale(${s})" fill="none" stroke="rgba(255,255,255,0.55)" stroke-width="10" stroke-linecap="round">
      <path class="st1" d="M-40 0 Q-60 -40 -40 -80 Q-20 -120 -40 -160"/>
      <path class="st2" d="M0 -10 Q-20 -50 0 -90 Q20 -130 0 -170"/>
      <path class="st3" d="M40 0 Q20 -40 40 -80 Q60 -120 40 -160"/>
    </g>`;
  }

  // ---------- Street with the two facing shops ----------
  // mood: golden | morning | evening | night
  function street(opts = {}) {
    const mood = opts.mood || "golden";
    const sky = {
      golden: ["#FFB347", "#FFDFA0"],
      morning: ["#9FD3F2", "#FFF1D0"],
      evening: ["#E9733A", "#5B3A6A"],
      night: ["#141A3A", "#3A2A55"],
    }[mood];
    const light = { golden: 1, morning: 0.95, evening: 0.7, night: 0.45 }[mood];
    const id = opts.id || "street";
    return `
<svg class="street" id="${id}" viewBox="0 0 1080 1920" preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="${id}-sky" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="${sky[1]}"/><stop offset="1" stop-color="${sky[0]}"/></linearGradient>
    <linearGradient id="${id}-road" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#8A6A4A"/><stop offset="1" stop-color="#5A4030"/></linearGradient>
    <radialGradient id="${id}-glow" cx="0.5" cy="0.38" r="0.6"><stop offset="0" stop-color="rgba(255,210,120,${0.55 * light})"/><stop offset="1" stop-color="rgba(255,210,120,0)"/></radialGradient>
    <filter id="${id}-blur"><feGaussianBlur stdDeviation="3"/></filter>
  </defs>
  <rect width="1080" height="1920" fill="url(#${id}-sky)"/>
  ${mood === "night" ? `<g fill="#fff" opacity="0.7"><circle cx="140" cy="160" r="3"/><circle cx="420" cy="90" r="2"/><circle cx="760" cy="200" r="3"/><circle cx="960" cy="110" r="2"/><circle cx="600" cy="300" r="2"/></g><circle cx="860" cy="260" r="46" fill="#FFF3C4" opacity="0.85"/>` : `<circle cx="540" cy="760" r="${mood === "evening" ? 120 : 160}" fill="${mood === "morning" ? "#FFF6D8" : "#FFE08A"}" opacity="0.85"/>`}
  <!-- distant buildings -->
  <g filter="url(#${id}-blur)" opacity="${0.75 * light + 0.2}">
    <rect x="300" y="640" width="120" height="260" fill="#C98A5B"/><rect x="420" y="600" width="90" height="300" fill="#B36E44"/>
    <rect x="570" y="620" width="100" height="280" fill="#D39A62"/><rect x="670" y="660" width="120" height="240" fill="#A65F3A"/>
    <path d="M520 560 L540 520 L560 560 L560 900 L520 900 Z" fill="#9C4E2E"/>
  </g>
  <!-- road receding to vanishing point -->
  <path d="M470 900 L610 900 L1080 1920 L0 1920 Z" fill="url(#${id}-road)"/>
  <path d="M536 900 L544 900 L560 1920 L520 1920 Z" fill="#E8D7B0" opacity="0.35"/>
  <!-- LEFT: Dolu Biryani Kadai -->
  <g id="${id}-dolushop">
    <path d="M0 520 L470 860 L470 1060 L0 1500 Z" fill="#F2C27B"/>
    <path d="M0 520 L470 860 L470 890 L0 600 Z" fill="${C.saffronDeep}"/>
    <!-- striped awning -->
    <path d="M0 660 L470 900 L470 960 L0 820 Z" fill="${C.saffron}"/>
    <path d="M0 700 L470 914 M0 740 L470 928 M0 780 L470 944" stroke="#FFF4DE" stroke-width="16" opacity="0.9"/>
    <!-- hand-painted signboard -->
    <g transform="translate(40 520) skewY(36)">
      <rect x="0" y="0" width="380" height="120" rx="10" fill="${C.brown}" stroke="${C.yellow}" stroke-width="8"/>
      <text x="190" y="54" text-anchor="middle" font-family="PoppinsXB" font-size="46" fill="${C.yellow}">DOLU</text>
      <text x="190" y="100" text-anchor="middle" font-family="PoppinsB" font-size="30" fill="#fff">BIRYANI KADAI</text>
    </g>
    <!-- doorway + counter -->
    <path d="M110 900 L380 1030 L380 1290 L110 1400 Z" fill="#3A1D0C"/>
    <path d="M110 1180 L380 1170 L380 1290 L110 1400 Z" fill="#7A4A26"/>
    <path d="M110 1180 L380 1170 L380 1186 L110 1200 Z" fill="#A86A3C"/>
    <rect id="${id}-posterframe" x="0" y="0" width="1" height="1" fill="none"/>
  </g>
  <!-- RIGHT: Bolu's rival shop, directly opposite -->
  <g id="${id}-bolushop">
    <path d="M1080 520 L610 860 L610 1060 L1080 1500 Z" fill="#CFE3C8"/>
    <path d="M1080 520 L610 860 L610 890 L1080 600 Z" fill="#2E7D4F"/>
    <path d="M1080 660 L610 900 L610 960 L1080 820 Z" fill="#3E9A62"/>
    <path d="M1080 700 L610 914 M1080 740 L610 928 M1080 780 L610 944" stroke="#E6F4E0" stroke-width="16" opacity="0.85"/>
    <g transform="translate(660 744) skewY(-36)">
      <rect x="0" y="0" width="380" height="120" rx="10" fill="#0F3A24" stroke="#E6F4E0" stroke-width="8"/>
      <text x="190" y="54" text-anchor="middle" font-family="PoppinsXB" font-size="46" fill="#E6F4E0">BOLU</text>
      <text x="190" y="100" text-anchor="middle" font-family="PoppinsB" font-size="28" fill="${C.yellow}">BIRYANI CENTRE</text>
    </g>
    <path d="M970 900 L700 1030 L700 1290 L970 1400 Z" fill="#1E2A20"/>
    <!-- shop pillar Bolu leans on -->
    <rect x="660" y="980" width="34" height="380" fill="#E6DCC6"/>
  </g>
  <rect width="1080" height="1920" fill="url(#${id}-glow)"/>
  ${mood === "evening" ? `<rect width="1080" height="1920" fill="rgba(40,30,90,0.22)"/>` : ""}
  ${mood === "night" ? `<rect width="1080" height="1920" fill="rgba(10,15,50,0.35)"/><circle cx="380" cy="1000" r="90" fill="rgba(255,200,100,0.25)"/>` : ""}
</svg>`;
  }

  window.ART = { C, rng, dolu, bolu, crowd, person, handi, steam, street };
})();
