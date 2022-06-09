import Urbit from '@urbit/http-api';
import { writable } from 'svelte/store';

const urbit = new Urbit("");

export const metas = writable(null);
export const active = writable("req");
export const edit = writable(false);

export function scryUrbit(ship, path) {
  urbit.ship = ship
  const msg = urbit.scry({
    app: "forms",
    path: path,
  })
  return msg
}

export function setActive(ship, id) {
  const path = "/survey/" + id
  scryUrbit(ship, path)
    .then( res => active.set(res))
} 

export function editQuestion(data) {
  urbit.poke({
    app: "forms",
    mark: "forms-action",
    json: {"qedit": data},
    onSuccess: ()=>(console.log("edit success")),
    onError: ()=>(console.log("error handling"))
})}

export function newQuestion() {
  urbit.poke({
    app: "forms",
    mark: "forms-action",
    json: {"qnew":
      {
        surveyid: "108.446.830.520.448.364",
        "qtitle": "this is a test questions",
        "front": "short",
        "back": "text",
        "required": false,
        "x": ["a", "b"],
        "y": ["cc", "dd"]
      },
      onSuccess: ()=>(handleMetas(ship)),
      onError: ()=>(console.log("error handling"))
    }
  })
}

function subFail() {
  console.log("err")  
}

export function createSurvey(ship, data) {
  if (data.title && data.description && data.slug) {
    urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"create": data},
      onSuccess: ()=>(handleMetas(ship)),
      onError: ()=>(console.log("error handling"))
    })
  } else {console.log("details cannot be empty!")}
}

export function requestSurvey(ship, data) {
  let arr = data.split("/")
  urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"ask":{"author": arr[0],"slug":arr[1]}},
      onSuccess: ()=>(makeContact(ship)),
      onError: ()=>(console.log("error handling"))
  })
}

export function deleteSurvey(ship, data) {
  console.log(data)
  const urbit = new Urbit("")
  urbit.ship = ship
  urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"delete": data},
      onSuccess: ()=>(console.log("deleted survey")),
      onError: ()=>(console.log("error handling"))
  })
}
