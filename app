<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover">
<title>ドロー大富豪</title>
<style>
*{box-sizing:border-box;-webkit-tap-highlight-color:transparent}
html,body{margin:0;height:100%;background:#0a321d;color:#f1f8e9;font-family:-apple-system,"Hiragino Sans","Noto Sans JP","Yu Gothic",Meiryo,sans-serif;overscroll-behavior:none}
body{touch-action:manipulation}
#app{height:100vh;height:100dvh;max-width:960px;margin:0 auto;display:flex;flex-direction:column;background:radial-gradient(ellipse at center,#1b6b3f 0%,#0f4a2a 70%,#0a321d 100%)}
#top{display:flex;flex-wrap:wrap;align-items:center;gap:4px 8px;padding:6px 8px;background:rgba(0,0,0,.35)}
.ttl{font-weight:800;font-size:15px;color:#ffd54a}
.chips{display:flex;flex-wrap:wrap;gap:4px;flex:1}
.chip{font-size:11px;padding:2px 8px;border-radius:99px;background:rgba(0,0,0,.4)}
.chip.on{background:#d32f2f;font-weight:700}
.tbtns{display:flex;gap:4px}
.mini-btn{border:1px solid rgba(255,255,255,.4);background:rgba(255,255,255,.1);color:#fff;border-radius:8px;font-size:12px;padding:5px 8px;cursor:pointer}
#opps{display:grid;grid-template-columns:repeat(3,1fr);gap:6px;padding:6px 8px 2px}
.opp{background:rgba(0,0,0,.28);border-radius:10px;padding:4px 6px;text-align:center;border:2px solid transparent;transition:.2s}
.opp.active{border-color:#ffd54a;box-shadow:0 0 12px rgba(255,213,74,.6)}
.opp .nm{font-size:12px;font-weight:700}
.opp .cnt{font-size:11px;opacity:.9}
.backs{display:flex;justify-content:center;height:31px;margin-top:3px;--cw:22px}
.backs .card{margin-left:-14px;box-shadow:0 1px 2px rgba(0,0,0,.5)}
.backs .card:first-child{margin-left:0}
#table{flex:1;min-height:0;position:relative;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:4px 8px;gap:4px}
#order{font-size:11px;opacity:.9;text-align:center}
#order.rev{color:#ff8a80;font-weight:700}
#fieldLabel{font-size:12px;min-height:16px;text-align:center}
#field{--cw:clamp(42px,11vw,68px);display:flex;justify-content:center;align-items:center;flex-wrap:wrap;min-height:calc(var(--cw)*1.4);gap:0 2px}
#field .card{animation:pop .25s ease-out}
.emptyNote{opacity:.55;font-size:13px}
@keyframes pop{from{transform:scale(.6) translateY(20px);opacity:0}to{transform:none;opacity:1}}
#banner{position:absolute;left:50%;top:42%;transform:translate(-50%,-50%) scale(0);opacity:0;font-size:clamp(26px,8vw,54px);font-weight:900;color:#fff;text-shadow:0 0 12px #ff6f00,0 3px 6px rgba(0,0,0,.8);white-space:nowrap;pointer-events:none;z-index:20}
#banner.show{animation:bpop .9s ease forwards}
@keyframes bpop{0%{transform:translate(-50%,-50%) scale(.3);opacity:0}20%{transform:translate(-50%,-50%) scale(1.15);opacity:1}80%{transform:translate(-50%,-50%) scale(1);opacity:1}100%{transform:translate(-50%,-50%) scale(1.05);opacity:0}}
#log{width:100%;max-width:560px;height:60px;overflow-y:auto;font-size:11px;background:rgba(0,0,0,.3);border-radius:8px;padding:4px 8px;line-height:1.5}
#me{padding:4px 8px calc(6px + env(safe-area-inset-bottom));background:rgba(0,0,0,.38);border-top:2px solid transparent}
#me.active{border-top-color:#ffd54a}
#hint{font-size:12px;min-height:18px;text-align:center;color:#ffe082;line-height:1.4}
#actions{display:flex;gap:6px;margin:4px 0}
.btn{flex:1;min-height:44px;border:0;border-radius:10px;font-size:15px;font-weight:700;color:#fff;cursor:pointer}
.btn.draw{background:#1976d2}
.btn.play{background:#e65100;flex:1.4}
.btn.pass{background:#546e7a}
.btn:disabled{opacity:.35;cursor:not-allowed}
#hand{--cw:clamp(44px,11.6vw,72px);display:flex;flex-wrap:wrap;justify-content:center;gap:12px 3px;padding:14px 2px 4px;max-height:38vh;overflow-y:auto;-webkit-overflow-scrolling:touch}
/* cards */
.card{width:var(--cw);height:calc(var(--cw)*1.4);border-radius:calc(var(--cw)*.12);background:#fff;color:#222;position:relative;flex:0 0 auto;box-shadow:0 2px 5px rgba(0,0,0,.45);font-size:calc(var(--cw)*.3);font-weight:700;user-select:none;-webkit-user-select:none;transition:transform .12s,box-shadow .12s,filter .12s;font-family:Georgia,"Times New Roman",serif}
.card.red{color:#d32f2f}.card.black{color:#1a1a1a}
.card .corner{position:absolute;line-height:1;text-align:center}
.card .corner.tl{top:5%;left:7%}
.card .corner.br{bottom:5%;right:7%;transform:rotate(180deg)}
.card .corner b{display:block;font-size:1em}
.card .corner i{display:block;font-style:normal;font-size:.85em}
.card .center{position:absolute;inset:0;display:flex;align-items:center;justify-content:center;font-size:2.1em;opacity:.9}
.card.joker{background:linear-gradient(145deg,#fff 0%,#fff3e0 50%,#f8bbd0 100%);color:#8e24aa}
.card.joker .jstar{position:absolute;inset:0;display:flex;align-items:center;justify-content:center;font-size:2.3em}
.card.joker .jtxt{position:absolute;left:8%;top:6%;writing-mode:vertical-rl;text-orientation:upright;font-size:.46em;line-height:1;font-family:sans-serif}
.card.back{background:repeating-linear-gradient(45deg,#1e4fb3 0 4px,#2f6be0 4px 8px);border:2px solid #fff}
#hand .card,.mhand .card{cursor:pointer}
.card.sel{transform:translateY(-12px);box-shadow:0 0 0 3px #ffca28,0 6px 12px rgba(0,0,0,.5)}
.card.dim{filter:brightness(.68)}
.card.new{box-shadow:0 0 0 3px #4fc3f7,0 2px 5px rgba(0,0,0,.45)}
.card.new.sel{box-shadow:0 0 0 3px #ffca28,0 6px 12px rgba(0,0,0,.5)}
/* modal */
.overlay{position:fixed;inset:0;background:rgba(0,0,0,.65);display:flex;align-items:center;justify-content:center;z-index:100;padding:10px}
.modal{background:#163d28;border:2px solid #ffd54a;border-radius:14px;padding:14px;max-width:560px;width:100%;max-height:92vh;overflow:auto;box-shadow:0 10px 40px rgba(0,0,0,.6)}
.modal h2{margin:0 0 6px;font-size:18px;color:#ffd54a}
.modal p{margin:4px 0 8px;font-size:13px;line-height:1.5}
.modal ul{padding-left:18px;margin:6px 0 12px;font-size:12.5px;line-height:1.6}
.modal .row{display:flex;flex-wrap:wrap;gap:8px;justify-content:center;margin:8px 0}
.tbtn{padding:10px 14px;border-radius:10px;border:2px solid #fff;background:transparent;color:#fff;font-weight:700;font-size:14px;cursor:pointer}
.tbtn.on{background:#e65100;border-color:#ffd54a}
.mhand{--cw:clamp(40px,10.5vw,60px);display:flex;flex-wrap:wrap;gap:12px 3px;justify-content:center;padding:14px 0 6px}
.grid13{display:grid;grid-template-columns:repeat(5,1fr);gap:8px;margin:8px 0}
.rbtn{padding:8px 0;border-radius:10px;border:2px solid #fff;background:rgba(255,255,255,.08);color:#fff;cursor:pointer;display:flex;flex-direction:column;align-items:center}
.rbtn b{font-size:20px}.rbtn small{font-size:10px;opacity:.8}
.rbtn:active{background:#e65100}
</style>
</head>
<body>
<div id="app">
  <header id="top">
    <div class="ttl">ドロー大富豪</div>
    <div class="chips">
      <span class="chip" id="chipDeck"></span><span class="chip" id="chipDis"></span>
      <span class="chip" id="chipRev"></span><span class="chip" id="chipEle"></span>
    </div>
    <div class="tbtns"><button class="mini-btn" id="btnRules">ルール</button><button class="mini-btn" id="btnRestart">最初から</button></div>
  </header>
  <section id="opps">
    <div class="opp" id="opp1"><div class="nm">CPU1</div><div class="cnt"></div><div class="backs"></div></div>
    <div class="opp" id="opp2"><div class="nm">CPU2</div><div class="cnt"></div><div class="backs"></div></div>
    <div class="opp" id="opp3"><div class="nm">CPU3</div><div class="cnt"></div><div class="backs"></div></div>
  </section>
  <section id="table">
    <div id="order"></div>
    <div id="fieldLabel"></div>
    <div id="field"></div>
    <div id="banner"></div>
    <div id="log"></div>
  </section>
  <section id="me">
    <div id="hint"></div>
    <div id="actions">
      <button class="btn draw" id="btnDraw">山札から引く</button>
      <button class="btn play" id="btnPlay">出す</button>
      <button class="btn pass" id="btnPass">パス</button>
    </div>
    <div id="hand"></div>
  </section>
</div>

<script>
'use strict';
const $=s=>document.querySelector(s);
const CANCEL={cancel:true};
const SUIT_SYM={S:'♠',H:'♥',D:'♦',C:'♣'};
const RL={1:'A',2:'2',3:'3',4:'4',5:'5',6:'6',7:'7',8:'8',9:'9',10:'10',11:'J',12:'Q',13:'K'};
const NAMES=['あなた','CPU1','CPU2','CPU3'];
const S={gen:0,hands:[[],[],[],[]],deck:[],discard:[],field:null,trick:[],revolution:false,elevenBack:false,
  turn:0,over:false,drawn:false,awaiting:false,humanDone:null,sel:[],newIds:new Set(),log:[]};
let fieldSig=null;

/* ---------- utilities ---------- */
function sleep(ms){const g=S.gen;return new Promise((res,rej)=>setTimeout(()=>g===S.gen?res():rej(CANCEL),ms));}
function shuffle(a){for(let i=a.length-1;i>0;i--){const j=Math.floor(Math.random()*(i+1));[a[i],a[j]]=[a[j],a[i]];}return a;}
function log(m){S.log.push(m);if(S.log.length>80)S.log.shift();}
function makeDeck(){
  let id=0;const d=[];
  for(const s of ['S','H','D','C'])for(let r=1;r<=13;r++)d.push({id:id++,suit:s,rank:r,joker:false});
  d.push({id:id++,suit:'X',rank:0,joker:true},{id:id++,suit:'X',rank:0,joker:true});
  return d;
}
function cardsText(cs){return cs.map(c=>c.joker?'JOKER':SUIT_SYM[c.suit]+RL[c.rank]).join(' ');}
function suitIdx(c){return c.joker?4:'SHDC'.indexOf(c.suit);}

/* ---------- strength ---------- */
function baseStr(r){if(r===0)return 100;if(r===1)return 14;if(r===2)return 15;return r;}
function isRev(){return S.revolution!==S.elevenBack;}
function effStr(r){if(r===0)return 100;const b=baseStr(r);return isRev()?18-b:b;}
function sortHand(h){h.sort((a,b)=>baseStr(a.rank)-baseStr(b.rank)||suitIdx(a)-suitIdx(b));}
function displayHand(h){return h.slice().sort((a,b)=>effStr(a.rank)-effStr(b.rank)||suitIdx(a)-suitIdx(b));}
function removeCards(i,cs){const h=S.hands[i];cs.forEach(c=>{const k=h.indexOf(c);if(k>=0)h.splice(k,1);});}

/* ---------- play analysis ---------- */
function analyze(cards){
  if(!cards.length)return null;
  const non=cards.filter(c=>!c.joker);const jk=cards.length-non.length;
  if(!non.length)return{rank:0,n:cards.length,jk,cards};
  const r=non[0].rank;
  if(!non.every(c=>c.rank===r))return null;
  return{rank:r,n:cards.length,jk,cards};
}
function isSpade3Return(cards){
  const f=S.field;
  return !!f&&cards.length===1&&!cards[0].joker&&cards[0].suit==='S'&&cards[0].rank===3&&f.n===1&&(f.rank===2||f.rank===0);
}
function validate(cards){
  if(!cards.length)return{ok:false,reason:'カードを選んでください'};
  const pl=analyze(cards);
  if(!pl)return{ok:false,reason:'同じ数字のカードだけを選んでください（ジョーカーは混ぜられます）'};
  if(!S.field)return{ok:true,play:pl};
  if(isSpade3Return(cards))return{ok:true,play:{...pl,spade3:true}};
  if(pl.n!==S.field.n)return{ok:false,reason:`場は${S.field.n}枚です。${S.field.n}枚で出してください`};
  if(!(effStr(pl.rank)>effStr(S.field.rank)))return{ok:false,reason:'場より強いカードを出してください'};
  return{ok:true,play:pl};
}
function getPlays(hand){
  const res=[];const f=S.field;
  const jokers=hand.filter(c=>c.joker);
  const by={};hand.filter(c=>!c.joker).forEach(c=>{(by[c.rank]=by[c.rank]||[]).push(c);});
  if(f&&f.n===1&&(f.rank===2||f.rank===0)){
    const s3=hand.find(c=>!c.joker&&c.suit==='S'&&c.rank===3);
    if(s3)res.push({cards:[s3],rank:3,n:1,jk:0,spade3:true});
  }
  const add=cards=>{const p=analyze(cards);if(!p)return;if(!f||(p.n===f.n&&effStr(p.rank)>effStr(f.rank)))res.push(p);};
  for(const r in by){
    const arr=by[r].slice().sort((a,b)=>(a.suit==='S'?1:0)-(b.suit==='S'?1:0));
    const c=arr.length;
    if(f){
      const m=f.n,k=Math.min(c,m),jj=m-k;
      if(k>=1&&jj<=jokers.length)add([...arr.slice(0,k),...jokers.slice(0,jj)]);
    }else{
      for(let k=1;k<=c;k++)add(arr.slice(0,k));
      for(let jj=1;jj<=jokers.length;jj++)add([...arr,...jokers.slice(0,jj)]);
    }
  }
  if(jokers.length){
    if(f){if(jokers.length>=f.n)add(jokers.slice(0,f.n));}
    else for(let k=1;k<=jokers.length;k++)add(jokers.slice(0,k));
  }
  return res;
}
function cardPlayable(c){
  const f=S.field;if(!f)return true;
  const hand=S.hands[0];const jk=hand.filter(x=>x.joker).length;
  if(!c.joker&&c.suit==='S'&&c.rank===3&&f.n===1&&(f.rank===2||f.rank===0))return true;
  const g={};hand.forEach(x=>{if(!x.joker)g[x.rank]=(g[x.rank]||0)+1;});
  const ok=r=>(g[r]||0)>=1&&g[r]+jk>=f.n&&effStr(r)>effStr(f.rank);
  if(c.joker){if(f.rank!==0&&jk>=f.n)return true;return Object.keys(g).some(r=>ok(+r));}
  return ok(c.rank);
}
function effectText(pl){
  if(pl.spade3)return 'スペ3返し！場を流して親になります';
  const a=[],n=pl.n;
  if(n>=4)a.push(S.revolution?'革命返し':'革命');
  switch(pl.rank){
    case 5:a.push(`5スキップ（${n}人）`);break;
    case 7:a.push(`7わたし（${n}枚）`);break;
    case 8:a.push('8切り');break;
    case 10:a.push(`10捨て（${n}枚）`);break;
    case 11:a.push('イレブンバック');break;
    case 12:a.push('12ボンバー');break;
  }
  return a.length?a.join(' ＋ '):`${n}枚出しOK`;
}

/* ---------- deck ---------- */
function canDraw(){return S.deck.length>0||S.discard.length>0;}
function drawCard(p){
  if(S.deck.length===0&&S.discard.length>0){S.deck=shuffle(S.discard.splice(0));log('山札が尽きたので、捨て札をシャッフルして新しい山札にした');}
  if(S.deck.length===0)return null;
  const c=S.deck.pop();S.hands[p].push(c);sortHand(S.hands[p]);return c;
}
function flowField(){
  S.discard.push(...S.trick);S.trick=[];S.field=null;
  if(S.elevenBack){S.elevenBack=false;log('イレブンバック解除');}
}
function findWinner(first){
  for(let i=0;i<4;i++){const q=(first+i)%4;if(S.hands[q].length===0)return q;}
  return -1;
}

/* ---------- rendering ---------- */
function cardEl(c){
  const d=document.createElement('div');
  if(c.joker){
    d.className='card joker';
    d.innerHTML='<span class="jtxt">JOKER</span><span class="jstar">★</span>';
  }else{
    d.className='card '+((c.suit==='H'||c.suit==='D')?'red':'black');
    const l=RL[c.rank],s=SUIT_SYM[c.suit];
    d.innerHTML=`<div class="corner tl"><b>${l}</b><i>${s}</i></div><div class="center">${s}</div><div class="corner br"><b>${l}</b><i>${s}</i></div>`;
  }
  return d;
}
function selCards(){return S.sel.map(id=>S.hands[0].find(c=>c.id===id)).filter(Boolean);}
function renderChips(){
  $('#chipDeck').textContent='山札 '+S.deck.length;
  $('#chipDis').textContent='捨て札 '+S.discard.length;
  const rc=$('#chipRev');rc.textContent='革命 '+(S.revolution?'中':'なし');rc.classList.toggle('on',S.revolution);
  const ec=$('#chipEle');ec.textContent='11バック '+(S.elevenBack?'中':'なし');ec.classList.toggle('on',S.elevenBack);
  const o=$('#order');o.classList.toggle('rev',isRev());
  o.textContent=isRev()?'強さ（逆転中）：弱 2 ＜ A ＜ K … ＜ 4 ＜ 3 ＜ JOKER 強':'強さ：弱 3 ＜ 4 … ＜ K ＜ A ＜ 2 ＜ JOKER 強';
}
function renderOpps(){
  for(let i=1;i<=3;i++){
    const p=$('#opp'+i),n=S.hands[i].length;
    p.querySelector('.cnt').textContent=n+'枚';
    const b=p.querySelector('.backs');b.innerHTML='';
    for(let k=0;k<Math.min(n,12);k++){const e=document.createElement('div');e.className='card back';b.appendChild(e);}
    p.classList.toggle('active',!S.over&&S.turn===i);
  }
  $('#me').classList.toggle('active',!S.over&&S.turn===0);
}
function renderField(){
  const f=$('#field');
  const sig=S.field?S.field.cards.map(c=>c.id).join(','):'';
  if(sig!==fieldSig){
    fieldSig=sig;f.innerHTML='';
    if(S.field)S.field.cards.forEach(c=>f.appendChild(cardEl(c)));
    else f.innerHTML='<div class="emptyNote">場は空です</div>';
  }
  $('#fieldLabel').textContent=S.field?`${NAMES[S.field.owner]} が出した ${S.field.n}枚`:(S.over?'':`${NAMES[S.turn]} が親です（好きなカードを出せます）`);
}
function renderHand(){
  const h=$('#hand');h.innerHTML='';
  S.sel=S.sel.filter(id=>S.hands[0].some(c=>c.id===id));
  displayHand(S.hands[0]).forEach(c=>{
    const el=cardEl(c);
    if(S.sel.includes(c.id))el.classList.add('sel');
    if(S.newIds.has(c.id))el.classList.add('new');
    if(S.awaiting&&!cardPlayable(c))el.classList.add('dim');
    el.addEventListener('click',()=>toggleSel(c.id));
    h.appendChild(el);
  });
}
function renderButtons(){
  const aw=S.awaiting&&!S.over;
  $('#btnDraw').disabled=!(aw&&!S.drawn&&canDraw());
  const sel=selCards(),v=validate(sel);
  const pb=$('#btnPlay');pb.disabled=!(aw&&v.ok);pb.textContent=sel.length?`出す（${sel.length}枚）`:'出す';
  const ps=$('#btnPass');ps.disabled=!(aw&&S.field);ps.textContent=S.drawn?'パス':'パス（1枚引く）';
}
function renderLog(){
  const l=$('#log');l.innerHTML='';
  S.log.slice(-30).forEach(t=>{const d=document.createElement('div');d.textContent=t;l.appendChild(d);});
  l.scrollTop=l.scrollHeight;
}
function renderHint(){
  const h=$('#hint');
  if(S.over){h.textContent='';return;}
  if(!S.awaiting){h.textContent=S.turn===0?'処理中…':`${NAMES[S.turn]} の番です`;return;}
  const sel=selCards();
  if(!sel.length){
    h.textContent=S.field?`場は${S.field.n}枚。より強い${S.field.n}枚を選んで「出す」${S.drawn?'':'（出せるのにパスすると1枚引きます）'}`
      :'あなたが親です。好きなカードを選んで「出す」（同じ数字は複数枚OK）';
    return;
  }
  const v=validate(sel);
  h.textContent=v.ok?'▶ '+effectText(v.play):v.reason;
}
function renderAll(){renderChips();renderOpps();renderField();renderHand();renderButtons();renderLog();renderHint();}
function announce(text,ms=850){
  const b=$('#banner');b.textContent=text;b.classList.remove('show');void b.offsetWidth;b.classList.add('show');
  return sleep(ms);
}

/* ---------- modal ---------- */
function modal(build){
  return new Promise(resolve=>{
    const ov=document.createElement('div');ov.className='overlay';
    const box=document.createElement('div');box.className='modal';
    ov.appendChild(box);document.body.appendChild(ov);
    build(box,v=>{ov.remove();resolve(v);});
  });
}
function pickCards({title,desc,count,targets}){
  return modal((box,close)=>{
    const hand=displayHand(S.hands[0]);
    let sel=[],target=null;const tb=[];
    box.innerHTML=`<h2>${title}</h2><p>${desc}</p>`;
    if(targets){
      const row=document.createElement('div');row.className='row';
      targets.forEach(t=>{
        const b=document.createElement('button');b.className='tbtn';b.textContent=`${NAMES[t]}（${S.hands[t].length}枚）`;
        b.onclick=()=>{target=t;tb.forEach(x=>x.classList.remove('on'));b.classList.add('on');upd();};
        tb.push(b);row.appendChild(b);
      });
      box.appendChild(row);
    }
    const hd=document.createElement('div');hd.className='mhand';box.appendChild(hd);
    const st=document.createElement('p');st.style.textAlign='center';box.appendChild(st);
    const ok=document.createElement('button');ok.className='btn play';ok.style.width='100%';ok.textContent='決定';box.appendChild(ok);
    function drawHand(){
      hd.innerHTML='';
      hand.forEach(c=>{
        const el=cardEl(c);if(sel.includes(c.id))el.classList.add('sel');
        el.onclick=()=>{
          const i=sel.indexOf(c.id);
          if(i>=0)sel.splice(i,1);else{if(sel.length>=count)sel.shift();sel.push(c.id);}
          upd();
        };
        hd.appendChild(el);
      });
    }
    function upd(){
      drawHand();
      st.textContent=`選択 ${sel.length} / ${count}枚`+(targets&&target===null?'　（相手も選んでください）':'');
      ok.disabled=!(sel.length===count&&(!targets||target!==null));
    }
    ok.onclick=()=>close({cards:sel.map(id=>hand.find(c=>c.id===id)),target});
    upd();
  });
}
function pickRank(){
  return modal((box,close)=>{
    box.innerHTML='<h2>12ボンバー</h2><p>全員の手札から捨てさせる数字を宣言してください（自分の手札も対象です）</p>';
    const g=document.createElement('div');g.className='grid13';
    for(let r=1;r<=13;r++){
      const own=S.hands[0].filter(c=>!c.joker&&c.rank===r).length;
      const b=document.createElement('button');b.className='rbtn';b.innerHTML=`<b>${RL[r]}</b><small>自分${own}枚</small>`;
      b.onclick=()=>close(r);g.appendChild(b);
    }
    box.appendChild(g);
  });
}
const RULES_HTML=`<h2>🃏 ドロー大富豪 ルール</h2>
<ul>
<li><b>基本</b>：あなた＋CPU3人。54枚（ジョーカー2枚）、最初は7枚。手札を最初に0枚にした人の勝ち。</li>
<li><b>ドロー</b>：自分の番に山札から1枚引けます（任意・1回）。出せるのにパスする場合／出せない場合は必ず1枚引きます（引いた札が出せればそのまま出せます）。</li>
<li><b>出し方</b>：場と同じ枚数で、より強い同じ数字を出します。全員パスで場が流れ、最後に出した人が親。</li>
<li><b>強さ</b>：3＜4＜…＜K＜A＜2＜JOKER。ジョーカーは他の数字と組めるワイルド（単独・ペアは最強）。手札は左が弱く右が強い並びです。</li>
<li><b>5スキップ</b>：出した枚数分の人数をスキップ。</li>
<li><b>7わたし</b>：出した枚数分、指定した相手に好きな手札を渡す。</li>
<li><b>8切り</b>：場が流れ、自分が親になる。</li>
<li><b>10捨て</b>：出した枚数分、自分の手札から捨てる。</li>
<li><b>イレブンバック</b>：Jを出すと強さが逆転（出すたびに切替・場が流れると解除）。</li>
<li><b>12ボンバー</b>：数字を1つ宣言し、全員（自分含む）の手札からその数字を捨てさせる。</li>
<li><b>スペ3返し</b>：場が単体の2またはジョーカーのとき、♠3で場を流して親になれる。</li>
<li><b>革命</b>：同じ数字を4枚以上（ジョーカー含む）で出すと強さが永久逆転。もう一度起きると元に戻る（革命返し）。</li>
<li>効果で手札が0枚になった人もその時点で勝ち（複数なら出した本人が優先）。山札が尽きたら捨て札をシャッフルして山札にします。</li>
<li><b>操作</b>：カードをタップで選択→「出す」。水色の枠は新しく手に入ったカード、暗いカードは今は出せません。</li>
</ul>`;
function showRules(first){
  return modal((box,close)=>{
    box.innerHTML=RULES_HTML;
    const b=document.createElement('button');b.className='btn play';b.style.width='100%';b.textContent=first?'ゲーム開始':'閉じる';
    b.onclick=()=>{close();if(first)startGame();};
    box.appendChild(b);
  });
}

/* ---------- CPU helpers ---------- */
function avgStr(cs){const n=cs.filter(c=>!c.joker);if(!n.length)return 9;return n.reduce((s,c)=>s+effStr(c.rank),0)/n.length;}
function cardValue(c,hand){
  if(c.joker)return 100;
  let v=effStr(c.rank);
  const same=hand.filter(x=>!x.joker&&x.rank===c.rank).length;
  v+=(same-1)*3;
  if(c.rank===3&&c.suit==='S')v+=4;
  if(c.rank===8)v+=3;
  return v;
}
function lowestValue(hand,k){return hand.slice().sort((a,b)=>cardValue(a,hand)-cardValue(b,hand)).slice(0,k);}
function scorePlay(pl,hand){
  const rem=hand.filter(c=>!pl.cards.includes(c));
  if(rem.length===0)return 10000;
  let sc=0;
  if(pl.spade3)sc+=14;
  const st=pl.rank===0?16:effStr(pl.rank);
  sc+=(16-st)*1.2+pl.n*2.5-pl.jk*14;
  if(pl.rank!==0){sc-=rem.filter(c=>!c.joker&&c.rank===pl.rank).length*2.5;}
  switch(pl.rank){
    case 8:sc+=12;break;
    case 10:sc+=5;break;
    case 7:sc+=5;break;
    case 5:sc+=2+pl.n;break;
    case 12:sc+=3;break;
    case 11:sc+=avgStr(rem)<8.5?4:-3;break;
  }
  if(pl.n>=4)sc+=avgStr(rem)<8.5?10:-12;
  return sc+Math.random()*1.5;
}
function cpuTarget(p){
  const o=[0,1,2,3].filter(i=>i!==p);
  const m=Math.min(...o.map(i=>S.hands[i].length));
  const c=o.filter(i=>S.hands[i].length===m);
  return c[Math.floor(Math.random()*c.length)];
}
function cpuBomberRank(p){
  const cnt={};S.hands[p].forEach(c=>{if(!c.joker)cnt[c.rank]=(cnt[c.rank]||0)+1;});
  let best=1,bv=-1;
  for(let r=1;r<=13;r++){const v=(cnt[r]||0)*10+(16-effStr(r))*0.3+Math.random();if(v>bv){bv=v;best=r;}}
  return best;
}

/* ---------- effects ---------- */
async function sevenPass(p,n){
  const hand=S.hands[p];if(!hand.length)return;
  const m=Math.min(n,hand.length);let target,cards;
  if(p===0){
    const r=await pickCards({title:`7わたし：${m}枚を渡す`,desc:'渡す相手と、渡すカードを選んでください',count:m,targets:[1,2,3]});
    target=r.target;cards=r.cards;
  }else{target=cpuTarget(p);cards=lowestValue(hand,m);await sleep(300);}
  removeCards(p,cards);S.hands[target].push(...cards);sortHand(S.hands[target]);
  log(`${NAMES[p]} は ${NAMES[target]} に${m}枚渡した`+(p===0?`（${cardsText(cards)}）`:''));
  if(target===0){cards.forEach(c=>S.newIds.add(c.id));log(`受け取った：${cardsText(cards)}`);}
  renderAll();await sleep(450);
}
async function tenDiscard(p,n){
  const hand=S.hands[p];if(!hand.length)return;
  const m=Math.min(n,hand.length);let cards;
  if(p===0){
    const r=await pickCards({title:`10捨て：${m}枚捨てる`,desc:'捨てるカードを選んでください',count:m});
    cards=r.cards;
  }else{cards=lowestValue(hand,m);await sleep(300);}
  removeCards(p,cards);S.discard.push(...cards);
  log(`${NAMES[p]} は${m}枚捨てた`+(p===0?`（${cardsText(cards)}）`:''));
  renderAll();await sleep(400);
}
async function bomber(p){
  let r;
  if(p===0)r=await pickRank();else{r=cpuBomberRank(p);await sleep(300);}
  const parts=[];
  for(let i=0;i<4;i++){
    const rem=S.hands[i].filter(c=>!c.joker&&c.rank===r);
    if(rem.length){removeCards(i,rem);S.discard.push(...rem);parts.push(`${NAMES[i]}${rem.length}枚`);}
  }
  log(`ボンバー！「${RL[r]}」を宣言 → `+(parts.length?parts.join('、')+' 捨てた':'誰も持っていなかった'));
  renderAll();await announce(`「${RL[r]}」を全員捨てる！`,900);
}

/* ---------- turn actions ---------- */
async function doPlay(p,pl){
  const hand=S.hands[p],nm=NAMES[p];
  if(p===0)S.newIds.clear();
  const sp3=isSpade3Return(pl.cards);
  removeCards(p,pl.cards);
  S.trick.push(...pl.cards);
  if(sp3){
    S.field={cards:pl.cards,rank:3,n:1,owner:p};
    log(`${nm} が ${cardsText(pl.cards)} 【スペ3返し！】`);
    renderAll();
    if(hand.length===0)return endGame(p);
    await announce('スペ3返し！');
    flowField();S.turn=p;log('場が流れた');renderAll();return;
  }
  S.field={cards:pl.cards,rank:pl.rank,n:pl.n,owner:p};
  log(`${nm} が ${cardsText(pl.cards)} を出した`);
  renderAll();
  if(hand.length===0)return endGame(p);
  await sleep(450);
  let skip=0;
  if(pl.n>=4){S.revolution=!S.revolution;log(S.revolution?'革命！強さが逆転した':'革命返し！強さが元に戻った');renderAll();await announce(S.revolution?'革命！':'革命返し！');}
  if(pl.rank===11){S.elevenBack=!S.elevenBack;log(S.elevenBack?'イレブンバック！':'イレブンバック解除');renderAll();await announce(S.elevenBack?'イレブンバック！':'イレブンバック解除');}
  if(pl.rank===5){skip=pl.n;log(`5スキップ！${pl.n}人スキップ`);await announce(`5スキップ！×${pl.n}`);}
  if(pl.rank===7){await announce(`7わたし！${pl.n}枚`);await sevenPass(p,pl.n);}
  if(pl.rank===10){await announce(`10捨て！${pl.n}枚`);await tenDiscard(p,pl.n);}
  if(pl.rank===12){await announce('12ボンバー！');await bomber(p);}
  const w=findWinner(p);if(w>=0)return endGame(w);
  if(pl.rank===8){await announce('8切り！');flowField();S.turn=p;log('場が流れた');renderAll();return;}
  const next=(p+1+skip)%4;
  if(S.field&&next===S.field.owner){await announce('場が流れた',550);flowField();log('場が流れた');}
  S.turn=next;renderAll();await sleep(200);
}
async function doPass(p){
  const nm=NAMES[p];
  let drew=false;
  if(!S.drawn){
    S.drawn=true;
    if(canDraw()){
      const c=drawCard(p);
      if(c){drew=true;if(p===0){S.newIds.add(c.id);log(`あなたは ${cardsText([c])} を引いた`);}}
    }else log(`${nm}：山札がなく引けない`);
  }
  log(`${nm}：パス`+(drew&&p!==0?'（1枚引いた）':''));
  renderAll();await sleep(350);
  const next=(p+1)%4;
  if(S.field&&next===S.field.owner){await announce('場が流れた',550);flowField();log('全員パス → 場が流れた');}
  S.turn=next;renderAll();
}
async function endGame(w){
  S.over=true;S.awaiting=false;
  log(`${NAMES[w]} の勝ち！`);renderAll();
  await announce(w===0?'あなたの勝ち！🎉':`${NAMES[w]} の勝ち`,1100);
  modal((box,close)=>{
    box.innerHTML=`<h2>${w===0?'🎉 あなたの勝ち（大富豪）！':NAMES[w]+' の勝ち'}</h2><p>残り枚数：${NAMES.map((n,i)=>`${n} ${S.hands[i].length}枚`).join('／')}</p>`;
    const b=document.createElement('button');b.className='btn play';b.style.width='100%';b.textContent='もう一度遊ぶ';
    b.onclick=()=>{close();startGame();};box.appendChild(b);
  });
}

/* ---------- CPU turn ---------- */
async function cpuTurn(p){
  const nm=NAMES[p],hand=S.hands[p];
  await sleep(650);
  let plays=getPlays(hand);
  if(plays.length&&!S.drawn&&hand.length>=5&&canDraw()&&Math.random()<0.12){
    drawCard(p);S.drawn=true;log(`${nm} は山札から1枚引いた`);renderAll();await sleep(450);
    plays=getPlays(hand);
  }
  if(!plays.length){
    if(!S.drawn){
      S.drawn=true;
      if(canDraw()){drawCard(p);log(`${nm} は出せないので山札から1枚引いた`);}
      renderAll();await sleep(500);
      plays=getPlays(hand);
    }
    if(!plays.length){await doPass(p);return;}
  }
  const scored=plays.map(pl=>({pl,sc:scorePlay(pl,hand)})).sort((a,b)=>b.sc-a.sc);
  const best=scored[0];
  if(S.field&&best.sc<9000&&!best.pl.spade3){
    const strong=best.pl.jk>0||(best.pl.rank!==0&&effStr(best.pl.rank)>=14);
    if(strong&&hand.length-best.pl.n>=3&&Math.random()<0.55){await doPass(p);return;}
  }
  await doPlay(p,best.pl);
}

/* ---------- human turn ---------- */
function waitHumanAction(){
  return new Promise(res=>{S.humanDone=res;S.awaiting=true;S.sel=[];renderAll();});
}
function finishHuman(){const d=S.humanDone;S.humanDone=null;if(d)d();}
async function humanTurn(){
  S.sel=[];renderAll();
  let plays=getPlays(S.hands[0]);
  if(!plays.length){
    if(!S.drawn){
      S.drawn=true;
      await announce('出せるカードなし → 1枚引く',800);
      if(canDraw()){
        const c=drawCard(0);
        if(c){S.newIds.add(c.id);log(`出せないので ${cardsText([c])} を引いた`);}
      }else log('出せるカードがなく、山札も空です');
      renderAll();
      plays=getPlays(S.hands[0]);
    }
    if(!plays.length){await sleep(400);await doPass(0);return;}
  }
  await waitHumanAction();
}
function toggleSel(id){
  if(!S.awaiting)return;
  const i=S.sel.indexOf(id);
  if(i>=0)S.sel.splice(i,1);else S.sel.push(id);
  renderHand();renderButtons();renderHint();
}
async function onPlay(){
  if(!S.awaiting)return;
  const v=validate(selCards());
  if(!v.ok){$('#hint').textContent=v.reason;return;}
  S.awaiting=false;S.sel=[];renderAll();
  try{await doPlay(0,v.play);finishHuman();}catch(e){if(e!==CANCEL)console.error(e);}
}
async function onPass(){
  if(!S.awaiting||!S.field)return;
  S.awaiting=false;renderAll();
  try{await doPass(0);S.newIds.clear();finishHuman();}catch(e){if(e!==CANCEL)console.error(e);}
}
async function onDraw(){
  if(!S.awaiting||S.drawn||!canDraw())return;
  try{
    const c=drawCard(0);S.drawn=true;
    if(c){S.newIds.add(c.id);log(`あなたは山札から ${cardsText([c])} を引いた`);}
    renderAll();
    if(S.field&&!getPlays(S.hands[0]).length){
      S.awaiting=false;renderAll();
      await announce('出せるカードなし → パス',700);
      await doPass(0);S.newIds.clear();finishHuman();
    }
  }catch(e){if(e!==CANCEL)console.error(e);}
}

/* ---------- main ---------- */
async function mainLoop(){
  const g=S.gen;
  try{
    while(!S.over&&g===S.gen){
      S.drawn=false;S.awaiting=false;
      renderAll();
      if(S.turn===0)await humanTurn();else await cpuTurn(S.turn);
    }
  }catch(e){if(e!==CANCEL)console.error(e);}
}
function startGame(){
  S.gen++;
  document.querySelectorAll('.overlay').forEach(o=>o.remove());
  const d=shuffle(makeDeck());
  S.hands=[[],[],[],[]];
  for(let k=0;k<7;k++)for(let i=0;i<4;i++)S.hands[i].push(d.pop());
  S.hands.forEach(sortHand);
  S.deck=d;S.discard=[];S.field=null;S.trick=[];
  S.revolution=false;S.elevenBack=false;S.over=false;S.drawn=false;S.awaiting=false;
  S.humanDone=null;S.sel=[];S.newIds=new Set();S.log=[];
  S.turn=Math.floor(Math.random()*4);
  fieldSig=null;
  log(`ゲーム開始！ 最初の親は ${NAMES[S.turn]}`);
  renderAll();
  mainLoop();
}

$('#btnDraw').addEventListener('click',onDraw);
$('#btnPlay').addEventListener('click',onPlay);
$('#btnPass').addEventListener('click',onPass);
$('#btnRules').addEventListener('click',()=>showRules(false));
$('#btnRestart').addEventListener('click',()=>{if(confirm('最初からやり直しますか？'))startGame();});
renderAll();
showRules(true);
</script>
</body>
</html>
