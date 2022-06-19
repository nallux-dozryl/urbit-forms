<script>
  import { active, setActive } from '../UrbitStore'

    export let title;
    export let author;
    export let id;

    let activeID;

    active.subscribe(res => activeID = res[0].id) 
    function changeState(ship, id) {
        setActive(ship, id)
    }

</script>
<div 
  class="item {activeID === id ? "active" : ""}" 
  on:click={()=> changeState(window.ship, id)}
>
    <div class="title">{title}</div>
    <div class="author">
      {!(author === window.ship) 
        ? "~" + author 
        : "me"
      }
    </div>
</div>
<style>
  
  .item {
    display: flex;
    flex-direction: column;
    border-top: 1px solid black;
    height: 2em;
    padding: 1em;
  }

  .item:hover {
    background: black;
    color: white;
  }

  .active {
    background: #1e1e1e;
    color: white;
  }

  .title {
    font-size: 1em;
  }

  .author {
    font-size: .7em;
  }

</style>
