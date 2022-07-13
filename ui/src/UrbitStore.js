import Urbit from '@urbit/http-api';
import { writable } from 'svelte/store';

// init
const urbit = new Urbit("");

// stores
export const metas = writable(null);
export const active = writable(null);
export const submissions = writable(null);
export const isAdmin = writable(false);
export const isCreate = writable(null);
export const requesting = writable(false);
export const formSettingsTab = writable("questions");
export const submitting = writable(false);

// new

export function initMetas(ship) {
  urbit.ship = ship

  urbit.subscribe({
    app: "forms",
    path: "/header/all",
    event: updateInfo,
    quit: reSub,
    err: reSub
  })
}

export function requestForm(ship, data) {
  requesting.set(true)
  let arr = data.split("/")
  urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"ask":{"author": arr[0],"slug":arr[1]}},
      onSuccess: ()=>(console.log("waiting...")),
      onError: ()=>(console.log("error handling"))
  })
}

export function getForm(ship, addr) {
  urbit.ship = ship
  scryUrbit("/active/" + addr).then(res => active.set(res))
}

export function getSubmissions(id) {
  scryUrbit("/submissions/" + id).then(res => submissions.set(res))
}

// internal only
function updateInfo(e) {
  if (e.flag === "refresh") {
    refreshMetas()
  }
  if (e.flag === "created") {
    console.log("created todo:ln 56 store | id: " + e.id)
  }

  if (e.flag === "requested") {
    requesting.set(false)
  
    if (e.status === "fail") {
      console.log("form doesn't exist") 
    } else if (e.status === "summon") {
      window.location.href = "/apps/forms/" + e.addr;
      console.log("summon the form!")
      console.log("addr: " + e.addr)
    }
  }
}

function reSub() {
  console.log("unsubbed")
}

function refreshMetas() {
  scryUrbit("/header").then(res => {
    metas.set(res)
    console.log("displaying latest information")
  })
}

function scryUrbit(path) {
  const msg = urbit.scry({
    app: "forms",
    path: path,
  })
  return msg
}

export function createSurvey(data) {
    urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"create": data},
      onSuccess: ()=>(
        window.location.href = "/apps/forms/~" + urbit.ship + "/" + data.slug
      ),
      onError: ()=>(console.log("createSurvey: error"))
    })
}

/* Edit Metadata */
export function editTitle(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-edit",
    json: {"title": data},
    onSuccess: ()=>(console.log("title edited")),
    onError: ()=>(console.log("error handling"))
})}

export function editDesc(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-edit",
    json: {"description": data},
    onSuccess: ()=>(console.log("description edited")),
    onError: ()=>(console.log("error handling"))
})}

export function editSlug(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-edit",
    json: {"slug": data},
    onSuccess: ()=>(console.log("slug edited")),
    onError: ()=>(console.log("error handling"))
})}

export function editVis(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-edit",
    json: {"visibility": data},
    onSuccess: ()=>(console.log("visibility edited")),
    onError: ()=>(console.log("error handling"))
})}

export function editResLimit(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-edit",
    json: {"rlimit": data},
    onSuccess: ()=>(console.log("response limit edited")),
    onError: ()=>(console.log("error handling"))
})}

export function addSection(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-edit",
    json: {"addsection": data},
    onSuccess: ()=>(console.log("section added")),
    onError: ()=>(console.log("error handling"))
})}

export function delSection(data, addr) {
  urbit.poke({
    app: "forms",
    mark: "forms-edit",
    json: {"delsection": data},
    onSuccess: ()=>(getForm(urbit.ship, addr)),
    onError: ()=>(console.log("error handling"))
  })
}

export function deleteForm(data) {
  urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"delete": data},
      onSuccess: ()=>(
        window.location.href = "/apps/forms/"
      ),
      onError: ()=>(console.log("deleteSurvey: error"))
  })
}

export function delSubmission(data) {
  urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"delsubmission": data},
      onSuccess: ()=>(console.log("submission deleted!")),
      onError: ()=>(console.log("delete submission: error"))
  })
}

export function addQuestion(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-edit",
    json: {"addquestion": data},
    onSuccess: ()=>(console.log("question inserted")),
    onError: ()=>(console.log("error handling"))
  })
}

export function delQuestion(addr, data) {
  urbit.poke({
    app: "forms",
    mark: "forms-edit",
    json: {"delquestion": data},
    onSuccess: ()=>{
      console.log("question removed")
      getForm(urbit.ship, addr)
    },
    onError: ()=>(console.log("error handling"))
  })
}

export function submitResponse(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-action",
    json: {submit: data},
    onSuccess: ()=>{
      window.location.href = "/apps/forms/"
      submitting.set(false)
    },
    onError: ()=>(console.log("error handling"))
  })
}

// answer pokes
export function editDraft(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-action",
    json: {"editdraft": data},
    onSuccess: ()=>(console.log("draft edited")),
    onError: ()=>(console.log("error handling"))
  })
}
