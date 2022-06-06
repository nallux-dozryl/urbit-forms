import Urbit from '@urbit/http-api';
import { writable } from 'svelte/store';

const urbit = new Urbit("");

export const surveys = writable(null);
export const active = writable(null);

export function makeContact(ship) {
  urbit.ship = ship
  window.id = urbit.subscribe({
    app: "forms",
    path: "/json",
    event: handleVoice,
    quit: reSub,
    err: subFail
  })
}

function handleVoice(update) {
  surveys.set(update)
}

function reSub() {
  console.log("quit")
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
      onSuccess: ()=>(makeContact(ship)),
      onError: ()=>(console.log("error handling"))
    })
  } else {console.log("details cannot be empty!")}
}

export function requestSurvey(ship, data) {
  const urbit = new Urbit("")
  urbit.ship = ship
  let arr = data.split("/")
  urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"ask":{"author": arr[0],"slug":arr[1]}},
      onSuccess: ()=>(console.log("request new surveys")),
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
