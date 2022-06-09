<script>
  import { active, edit, setActive } from '../UrbitStore'

    export let title;
    export let author;
    export let id;

    let info;
    let isAdmin;

    active.subscribe(res => {
		  info = res;
      });

    edit.subscribe(res => {
      isAdmin = res
      });

    function changeState(ship, id, ed) {
        setActive(ship, id)
        edit.set(ed)
    }

</script>
<div 
  class={info[0].id === id ? "item active" : "item"}
>
<div 
  class="info"
  on:click={()=> changeState(window.ship, id, false)}
>
    <div class="title">{title}</div>
    <div class="author">
      {!(author === window.ship) 
        ? "~" + author 
        : "me"
      }
    </div>
  </div>
  <div class="dropdown">
    <button class="gear">⚙</button>
    <div class="menu">
      <button 
        on:click={()=> changeState(window.ship, id, true)}
        class="setting">
        edit
      </button>
      <button class="setting">
        clone
      </button>
      <button class="delete">
        delete
      </button>
    </div>
  </div>
</div>

<style>
  
  .item {
    display: flex;
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

  .info {
    flex: 4;
  }

  .title {
    font-size: 1em;
  }

  .author {
    font-size: .7em;
  }

  .dropdown {
    flex: 1;
    text-align: right;
    margin: auto;
  }

  .menu {
    position: absolute;
    display:none;
  }

  .dropdown:hover .menu {
    display: flex;
    flex-direction: column;
    border: 1px solid black;
  }

  .setting {
    flex: 1;
    width: 5em;
    padding: .4em;
    border: none;
    background: white;
  }

  .setting:hover {
    color: white;
    background: black;
  }

  .delete {
    flex: 1;
    width: 5em;
    padding: .3em;
    background: white;
    border: none;
  }

  .delete:hover {
    background: red;
    color: white;
  }

  .gear {
    border: none;
    background: inherit;
    color: inherit;
  }

  .gear:hover {
    color: grey;
  }
</style>
