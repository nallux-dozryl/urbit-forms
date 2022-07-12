<script>

  import { active, deleteForm } from '../UrbitStore'

</script>

<div class="section">
  <div class="title">Admin</div>
  <button
    class="delete"
    on:click={deleteForm({id:$active[0].id})}
  >
    Delete Form
  </button>
</div>

<style>

  .section {
    margin: 2em 0 2em .6em;
  }

  .title {
    font-size: 1.2em;
    font-weight: 500;
  }

  .delete {
    background: white;
    border: solid 1px #f47174;
    color: #f47174;
  }

  .delete:hover {
    background: #f47174;
    color: white;
  }

  .delete:active {
    background: red;
    border-color: red;
    color: white;
  }

  button {
    padding: .6em;
    border-radius: 4px;
    margin: 1em 1em 0 0;
  }


</style>

