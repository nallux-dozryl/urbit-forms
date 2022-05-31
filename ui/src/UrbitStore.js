import Urbit from '@urbit/http-api';

export function getSurveys(ship) {
  const urbit = new Urbit("")
  urbit.ship = ship
    
  const surveys = urbit.scry({app: "forms", path: "/surveys/live"})

  return surveys
}

export function getDefunct(ship) {
  const urbit = new Urbit("")
  urbit.ship = ship
    
  const defunct = urbit.scry({app: "forms", path: "/surveys/defunct"})

  return defunct
}

export function createSurvey(ship, data) {
  if (data.title && data.description && data.slug) {
    const urbit = new Urbit("")
    urbit.ship = ship

    urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"create": data},
      onSuccess: ()=>(console.log("survey created!")),
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

