<script>
  import { edit, setActive } from '../UrbitStore'

    export let title;
    export let author;
    export let id;


    function changeState(ship, id, ed) {
        setActive(ship, id)
        edit.set(ed)
    }

</script>
<div class="item" on:click={()=> changeState(window.ship, id, false)}>
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
