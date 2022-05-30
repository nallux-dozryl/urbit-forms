<script>
  let addr;
  
  let requestSurvey = async () =>  {
    let arr = addr.split("/")
    return await window.urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {"ask":{"author": arr[0],"slug":arr[1]}},
      onSuccess: ()=>(console.log("request new surveys")),
      onError: ()=>(console.log("error handling"))
    })
  }

</script>

<div class="ask-form">
  <input 
    type="text" 
    placeholder="~zod/example-form" 
    bind:value={addr} 
  />
  <button 
    on:click={requestSurvey}
    class="request"
  >
    Request
  </button>
</div>

<style>

  input {
    flex: 8;
    border: 2px solid black;
    padding: .618em;
  }
  
  .ask-form {
    display: flex;
    margin: 0 2px .618em 2px;
  }

  .request {
    flex: 2;
    background: white;
    margin-left: .618em;
    border: 2px solid black;
  }

  .request:hover {
    background: black;
    color: white;
  }


</style>
